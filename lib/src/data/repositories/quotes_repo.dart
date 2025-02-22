import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'dart:convert';
import 'package:restful_solid_bloc/src/data/constants.dart';

// Abstract class defining the contract (Interface Segregation Principle)
abstract class QuotesRepository {
  Future<List<dynamic>> getRandomQuote();
}

// Implementation class (Single Responsibility Principle)
class QuotesRepositoryImpl implements QuotesRepository {
  final String baseUrl;


  // Dependency Injection (Dependency Inversion Principle)
  QuotesRepositoryImpl({
    required this.baseUrl,
  });

  @override
  Future<List<dynamic>> getRandomQuote() async {
    try {
      final response = await GetIt.I<Dio>().get(
        baseUrl,
        options: Options(
          headers: {
            'X-Api-Key': GetIt.instance<Constants>().quotesAPI,
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;
       
        return data;
      } else {
        throw ('Failed to load quote');
      }
    } catch (e) {
      throw ('Error fetching quote: $e');
    }
  }
}
