import 'dart:math';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:restful_solid_bloc/src/domain/anime_tags.dart';
import 'package:restful_solid_bloc/src/domain/local_database.dart';
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
  Future<List<String>> getImageForEachCategory(
      {required List<String> categories});
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

  List<String> categoriesList = [];

  void _makeCategoriesAsList(dynamic responce) {
    final categoriesMap =
        (responce['versatile'] as List) + (responce['nsfw'] as List);
    for (var element in categoriesMap) {
      categoriesList.add(
        element['name'].toString(),
      );
    }
    GetIt.I<IAnimeTags>().allAvailableTags = categoriesList;
  }

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

  @override
  Future<List<String>> getImageForEachCategory(
      {required List<String> categories}) async {
    if (GetIt.I<ILocalDatabase>().readData('categoryURL') != null) {
      return GetIt.I<ILocalDatabase>().readData('categoryURL');
    }
    List<String> imagesUrl = [];
    final getIt = GetIt.instance<IAnimeRepository>(
      instanceName: 'waifuRepository',
    );
    for (var category in categories) {
      try {
        await getIt.getAnimeMedia(
          tags: [
            category.toLowerCase(),
          ],
          isNsfw: false,
          amount: 2,
        ).then(
          (value) {
            imagesUrl.add(
              value['images'][0]['url'],
            );
          },
        );
      } catch (e) {
        imagesUrl.add(
          'https://i.pinimg.com/originals/f4/4b/96/f44b968e1981f48a3cadba22351150c0.jpg',
        );
      }
    }
    GetIt.I<ILocalDatabase>().writeData(
      'categoryURL',
      imagesUrl,
    );
    return imagesUrl;
  }

  Map<String, dynamic> handleResponse(Response response) {
    if (response.statusCode == 200) {
      _makeCategoriesAsList(response.data);
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
