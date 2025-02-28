// Network client interface for dependency injection
import 'package:dio/dio.dart';

abstract class INetworkClient {
  Future<Response> get(
      {required String path,
      Map<String, dynamic>? queryParameters,
      Options? options});
}

// Dio implementation of network client
class DioNetworkClient implements INetworkClient {
  final Dio _dio;
  DioNetworkClient(this._dio);

  @override
  Future<Response> get(
      {required String path,
      Map<String, dynamic>? queryParameters,
      Options? options}) {
    return _dio.get(
      path,
      queryParameters: queryParameters,
      options: options,
    );
  }
}
