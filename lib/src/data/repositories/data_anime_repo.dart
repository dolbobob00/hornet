import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

// Interface segregation principle (I in SOLID)
abstract class IAnimeRepository {
  Future<Map<String, dynamic>> getCategoryAndInfo();
  Future<Map<String, dynamic>> getAnimeMedia({
    bool isNsfw = true,
    bool isGif = false,
    int? amount,
    List<String>? tags,
  });
  void dispose();
}

// Single responsibility principle (S in SOLID)
class DataAnimeRepository implements IAnimeRepository {
  final String baseUrl;
  final http.Client _client;
  Map<String, dynamic> categoryInfo = {};

  // Singleton implementation
  static DataAnimeRepository? _instance;

  // Private constructor
  DataAnimeRepository._internal({
    required this.baseUrl,
    http.Client? client,
  }) : _client = client ?? http.Client();

  // Factory constructor
  factory DataAnimeRepository({
    required String baseUrl,
    http.Client? client,
  }) {
    _instance ??= DataAnimeRepository._internal(
      baseUrl: baseUrl,
      client: client,
    );
    return _instance!;
  }

  // Instance getter
  static DataAnimeRepository get instance {
    if (_instance == null) {
      throw StateError('Repository must be initialized with baseUrl first');
    }
    return _instance!;
  }

  // Reset instance (useful for testing)
  static void reset() {
    _instance?.dispose();
    _instance = null;
  }

  // Open-closed principle (O in SOLID) - extensible but closed for modification
  @override
  Future<Map<String, dynamic>> getAnimeMedia({
    bool isNsfw = true,
    bool isGif = false,
    int? amount,
    List<String>? tags,
  }) async {
    try {
      // Create base query parameters
      final Map<String, dynamic> queryParams = {
        'limit': amount?.toString() ?? '2',
        'is_nsfw': isNsfw ? 'true' : 'false', 
        'gif': isGif ? 'true' : 'false', 
        'included_tags': tags??[]
      };

      final response = await GetIt.I<Dio>().get(
        '$baseUrl/search',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to load anime details: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('API Error: ${e.response?.data ?? e.message}');
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> getCategoryAndInfo() async {
    if (categoryInfo.isNotEmpty) {
      return categoryInfo;
    }
    try {
      final response = await GetIt.I<Dio>().get(
        '$baseUrl/tags',
        queryParameters: {'full': 'true'},
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        categoryInfo = data;
        return data;
      } else {
        throw Exception('Failed to load anime list');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Liskov substitution principle (L in SOLID) is satisfied
  // as this class fully implements the IAnimeRepository interface
  @override
  void dispose() {
    _client.close();
  }
}