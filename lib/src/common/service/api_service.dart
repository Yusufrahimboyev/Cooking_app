import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

enum Method { get, put, post, delete }

class ApiService {
  const ApiService({required this.dio});

  final Dio dio;

  Future<bool> checkConnection() async {
    final connectivity = await Connectivity().checkConnectivity();
    return connectivity == ConnectivityResult.mobile ||
        connectivity == ConnectivityResult.wifi;
  }

  Future<Map<String, Object?>> request(
      String path, {
        Method method = Method.get,
        bool setToken = true,
        Object? data,
        Map<String, Object?>? headers,
        Map<String, Object?>? queryParams,
        FormData? formData,
      }) async {
    final sw = Stopwatch()..start();

    if (!await checkConnection()) {
      throw Exception('No internet connection');
    }

    try {
      final requestHeaders = {
        ...?headers,
        'Content-Type': formData != null ? 'multipart/form-data' : 'application/json',
      };

      final response = await dio.request<Map<String, Object?>>(
        path,
        data: data ?? formData,
        queryParameters: queryParams,
        options: Options(
          method: method.name,
          headers: requestHeaders,
        ),
      );

      if (response.statusCode == null || response.statusCode! >= 400 || response.data == null) {
        throw Exception('API Error ${response.statusCode}');
      }

      return response.data!;
    } catch (e, stackTrace) {
      debugPrint('API Exception: $e');
      debugPrintStack(stackTrace: stackTrace);
      rethrow;
    } finally {
      sw.stop();
      debugPrint('API call time: ${sw.elapsedMilliseconds} ms');
    }
  }
}
