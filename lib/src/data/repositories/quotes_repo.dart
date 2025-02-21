import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:restful_solid_bloc/src/data/constants.dart';

// Abstract class defining the contract (Interface Segregation Principle)
abstract class QuotesRepository {
  Future<List<dynamic>> getRandomQuote();
}

// Implementation class (Single Responsibility Principle)
class QuotesRepositoryImpl implements QuotesRepository {
  final String baseUrl;
  final http.Client _client;

  // Dependency Injection (Dependency Inversion Principle)
  QuotesRepositoryImpl({
    required this.baseUrl,
    http.Client? client,
  }) : _client = client ?? http.Client();

  @override
  Future<List<dynamic>> getRandomQuote() async {
    try {
      final response = await _client.get(
        Uri.parse(baseUrl),
        headers: {
          'X-Api-Key': quotesAPI,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data;
      } else {
        throw ('Failed to load quote');
      }
    } catch (e) {
      throw ('Error fetching quote: $e');
    }
  }
}
