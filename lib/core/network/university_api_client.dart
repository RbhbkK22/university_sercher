import 'package:dio/dio.dart';
import 'package:university_search/core/config/config.dart';

class UniversityApiClient {
  final Dio _dio;

  UniversityApiClient()
    : _dio = Dio(
        BaseOptions(
          baseUrl: config.universitiesApiUrl,
          connectTimeout: Duration(seconds: 50),
          receiveTimeout: Duration(seconds: 30),
        ),
      );

  Future<Response> get(String path, {Map<String, dynamic>? queryPrameters}) {
    return _dio.get(path, queryParameters: queryPrameters);
  }
}
