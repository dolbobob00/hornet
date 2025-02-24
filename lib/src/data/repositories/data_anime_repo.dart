import 'dart:math';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

// Interface segregation principle (I in SOLID)
abstract class IAnimeRepository {
  Future<Map<String, dynamic>> getCategoryAndInfo();
  Future<Map<String, dynamic>> getAnimeMedia({
    bool isNsfw = true,
    bool isGif = false,
    int? amount,
    List<String>? tags,
  });
}

// Single responsibility principle (S in SOLID)
class DataAnimeRepository implements IAnimeRepository {
  final String baseUrl;

  Map<String, dynamic> categoryInfo = {};
  // Private constructor
  DataAnimeRepository({
    required this.baseUrl,
  });

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
        'included_tags': tags ?? []
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
}

class Rule34AnimeRepository implements IAnimeRepository {
  final String baseUrl;
  Rule34AnimeRepository({required this.baseUrl});


  Random random = Random();
  @override
  Future<Map<String, dynamic>> getAnimeMedia({
    bool isNsfw = true,
    bool isGif = false,
    int? amount,
    List<String>? tags,
  }) async {
    try {
      String gif = isGif ? ' animated' : '';
      String tagsString = tags?.join()??'rem_(re:zero) cute lesbian';
      tagsString += gif;
      tagsString.toLowerCase();
      int randomPage;
      if (tagsString.length > 25) {
        randomPage = random.nextInt(2);
      }else{
         randomPage = random.nextInt(15);
      }
      final Map<String, dynamic> queryParams = {
        'limit': amount?.toString() ?? '35',
        's': 'post',
        'q': 'index',
        'json': 1,
        'tags': tagsString,
        'pid': randomPage.toString(),
      };

      final response = await GetIt.I<Dio>().get(
        baseUrl,
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        return {'images': response.data};
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
  Future<Map<String, dynamic>> getCategoryAndInfo() {
    // TODO: implement getCategoryAndInfo
    throw UnimplementedError();
  }
}
