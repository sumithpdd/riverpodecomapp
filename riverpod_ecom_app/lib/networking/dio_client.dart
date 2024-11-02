import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_ecom_app/networking/api_endpoints.dart';

class DioClient {
  final Dio _dio = Dio();

  DioClient() {
    _dio.options
      ..baseUrl = ApiEndpoints.BaseUrl
      ..connectTimeout = const Duration(seconds: 30)
      ..receiveTimeout = const Duration(seconds: 30)
      ..headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      };
  }
  Future<Response> get(String endPoint,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response =
          await _dio.get(endPoint, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }
}

final dioProvider = Provider<DioClient>((ref) => DioClient());
