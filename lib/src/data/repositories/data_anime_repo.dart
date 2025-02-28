import 'dart:math';
import 'package:dio/dio.dart';
import 'package:restful_solid_bloc/src/domain/network_client.dart';

// Base repository interface
abstract class IAnimeRepository {
  Future<Map<String, dynamic>> getAnimeMedia({
    bool isNsfw = true,
    bool isGif = false,
    int? page,
    int? amount,
    List<String>? tags,
  });
}

// Interface for category info operations
abstract class ICategoryRepository {
  Future<Map<String, dynamic>> getCategoryAndInfo();
}

//Category repo
class CategoryRepository implements ICategoryRepository {
  final INetworkClient networkClient;
  final String baseUrl;
  CategoryRepository({
    required this.baseUrl,
    required this.networkClient,
  });
  Map<String, dynamic> categoryInfo = {};

  @override
  Future<Map<String, dynamic>> getCategoryAndInfo() async {
    if (categoryInfo.isNotEmpty) {
      return categoryInfo;
    }
    try {
      final response = await networkClient
          .get(path: '$baseUrl/tags', queryParameters: {'full': 'true'});

      return handleResponse(response);
    } catch (e) {
      throw handleError(e);
    }
  }

  Map<String, dynamic> handleResponse(Response response) {
    if (response.statusCode == 200) {
      return response.data;
    }
    throw Exception('Failed to load anime details: ${response.statusCode}');
  }

  Exception handleError(dynamic e) {
    if (e is DioException) {
      return Exception('API Error: ${e.response?.data ?? e.message}');
    }
    return Exception('Network error: $e');
  }
}

// Base repository implementation
class BaseAnimeRepository implements IAnimeRepository {
  final String baseUrl;
  final INetworkClient networkClient;

  BaseAnimeRepository({
    required this.baseUrl,
    required this.networkClient,
  });

  Map<String, dynamic> categoryInfo = {};

  @override
  Future<Map<String, dynamic>> getAnimeMedia({
    bool isNsfw = true,
    bool isGif = false,
    int? page,
    int? amount,
    List<String>? tags,
  }) async {
    try {
      final queryParams = createQueryParams(
        isNsfw: isNsfw,
        isGif: isGif,
        amount: amount,
        tags: tags,
      );

      final response = await networkClient.get(
        path: '$baseUrl/search',
        queryParameters: queryParams,
      );

      return handleResponse(response);
    } catch (e) {
      throw handleError(e);
    }
  }

  Map<String, dynamic> createQueryParams({
    required bool isNsfw,
    required bool isGif,
    int? amount,
    List<String>? tags,
  }) {
    return {
      'limit': amount?.toString() ?? '2',
      'is_nsfw': isNsfw.toString(),
      'gif': isGif.toString(),
      'included_tags': tags ?? []
    };
  }

  Map<String, dynamic> handleResponse(Response response) {
    if (response.statusCode == 200) {
      return response.data;
    }
    throw Exception('Failed to load anime details: ${response.statusCode}');
  }

  Exception handleError(dynamic e) {
    if (e is DioException) {
      return Exception('API Error: ${e.response?.data ?? e.message}');
    }
    return Exception('Network error: $e');
  }
}

// Rule34 specific implementation
class Rule34AnimeRepository implements IAnimeRepository {
  final String baseUrl;
  final INetworkClient networkClient;
  final Random _random;

  Rule34AnimeRepository({
    required this.baseUrl,
    required this.networkClient,
    Random? random,
  }) : _random = random ?? Random();

  @override
  Future<Map<String, dynamic>> getAnimeMedia({
    bool isNsfw = true,
    bool isGif = false,
    int? page,
    int? amount,
    List<String>? tags,
  }) async {
    try {
      final queryParams = _createRule34QueryParams(
        isGif: isGif,
        amount: amount,
        tags: tags,
        page: page,
      );

      final response = await networkClient.get(
        path: baseUrl,
        queryParameters: queryParams,
      );

      return {'images': response.data};
    } catch (e) {
      throw handleError(e);
    }
  }

  Map<String, dynamic> _createRule34QueryParams({
    required bool isGif,
    int? amount,
    List<String>? tags,
    int? page,
  }) {
    final String tagsString = _formatTags(tags, isGif);
    final int pageNumber = _calculatePageNumber(page, tagsString);

    return {
      'limit': amount?.toString() ?? '35',
      's': 'post',
      'q': 'index',
      'json': 1,
      'tags': tagsString,
      'pid': pageNumber.toString(),
    };
  }

  String _formatTags(List<String>? tags, bool isGif) {
    String tagsString = tags?.join() ?? 'rem_(re:zero) animated';
    if (isGif) tagsString += ' animated';
    return tagsString.toLowerCase();
  }

  int _calculatePageNumber(int? page, String tagsString) {
    if (page == -1 || page == null) {
      if (tagsString.length > 16) {
        return _random.nextInt(5);
      }
      return tagsString.contains('animated')
          ? _random.nextInt(5)
          : _random.nextInt(15);
    }
    return page;
  }

  Exception handleError(dynamic e) {
    if (e is DioException) {
      return Exception('API Error: ${e.response?.data ?? e.message}');
    }
    return Exception('Network error: $e');
  }
}
