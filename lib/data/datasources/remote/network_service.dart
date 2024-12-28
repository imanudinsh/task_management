import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

import 'package:task_management/data/datasources/remote/endpoint.dart';

class NetworkService {
  final Dio dio;

  NetworkService()
      : dio = Dio(BaseOptions(baseUrl: Endpoint.baseURL));

  Future<Response> fetchData(String endpoint) async {
    try {
      final response = await dio.get(endpoint);
      return response;
    } on DioError catch (e, stackTrace) {
      debugPrintStack(label: e.toString(), stackTrace: stackTrace);
      throw _handleDioError(e);
    } on HttpException catch (e, stackTrace) {
      debugPrintStack(label: e.toString(), stackTrace: stackTrace);
      throw HttpException(e.message);
    } on SocketException catch (e, stackTrace) {
      debugPrintStack(label: e.toString(), stackTrace: stackTrace);
      throw SocketException(e.message);
    } catch (e) {
      throw HttpException(e.toString());
    }
  }

  Future<Response> insertData(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await dio.post(endpoint, data: data);
      return response;
    } on DioError catch (e, stackTrace) {
      debugPrintStack(label: e.toString(), stackTrace: stackTrace);
      throw _handleDioError(e);
    } on HttpException catch (e, stackTrace) {
      debugPrintStack(label: e.toString(), stackTrace: stackTrace);
      throw HttpException(e.message);
    } on SocketException catch (e, stackTrace) {
      debugPrintStack(label: e.toString(), stackTrace: stackTrace);
      throw SocketException(e.message);
    } catch (e, stackTrace) {
      debugPrintStack(label: e.toString(), stackTrace: stackTrace);
      throw HttpException(e.toString());
    }
  }

  Future<Response> updateData(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await dio.put(endpoint, data: data);
      return response;
    } on DioError catch (e, stackTrace) {
      debugPrintStack(label: e.toString(), stackTrace: stackTrace);
      throw _handleDioError(e);
    } on HttpException catch (e, stackTrace) {
      debugPrintStack(label: e.toString(), stackTrace: stackTrace);
      throw HttpException(e.message);
    } on SocketException catch (e, stackTrace) {
      debugPrintStack(label: e.toString(), stackTrace: stackTrace);
      throw SocketException(e.message);
    } catch (e) {
      throw HttpException(e.toString());
    }
  }

  Future<Response> deleteData(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await dio.delete(endpoint, data: data);
      return response;
    } on DioError catch (e, stackTrace) {
      debugPrintStack(label: e.toString(), stackTrace: stackTrace);
      throw _handleDioError(e);
    } on HttpException catch (e, stackTrace) {
      debugPrintStack(label: e.toString(), stackTrace: stackTrace);
      throw HttpException(e.message);
    } on SocketException catch (e, stackTrace) {
      debugPrintStack(label: e.toString(), stackTrace: stackTrace);
      throw SocketException(e.message);
    } catch (e) {
      throw HttpException(e.toString());
    }
  }

  // Custom error handling function
  Exception _handleDioError(DioError e) {
    if (e.response != null) {
      final statusCode = e.response?.statusCode;
      final message = e.response?.data['message'] ??  e.response?.data['error'] ?? 'Unknown error';
      
      if (statusCode == 400 || statusCode == 403 || statusCode == 404 || statusCode == 409 || statusCode == 500) {
        return Exception(message);
      } else {
        return Exception('Failed with status code $statusCode: ${e.response?.data}');
      }
    } else {
      return Exception('Network error: ${e.message}');
    }
  }
}
