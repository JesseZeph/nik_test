import 'dart:io';

import 'package:dio/dio.dart';
import 'package:niklaar/core/constants/app_strings.dart';
import 'package:niklaar/core/constants/constants.dart';
import 'package:niklaar/core/services/storage/secure_storage.dart';
import '../../../../data/models/network_response.dart';

class ApiService {
  final Dio _dio;

  ApiService(Dio instance) : _dio = instance;

  Future<NetworkResponse> getRequest({
    String? endpoint,
    Map<String, dynamic>? query,
    bool isProtected = true,
  }) async {
    try {
      final headers = isProtected ? await _fetchHeaders() : null;
      logMessage(
        'ApiService',
        'Making request to $endpoint with headers: $headers',
      );

      final response = await _dio.get(
        endpoint ?? '',
        queryParameters: query,
        options: Options(headers: headers),
      );

      final networkResponse = NetworkResponse.fromMap(response.data);

      return networkResponse;
    } catch (e) {
      if (e is SocketException) {
        return NetworkResponse(
          status: false,
          message: 'Poor internet connection!',
          data: null,
        );
      } else if (e is DioException) {
        return NetworkResponse(
          status: false,
          message: e.message ?? 'An error occured',
          data: null,
        );
      }
      return NetworkResponse(status: false, message: e.toString(), data: null);
    }
  }

  Future<NetworkResponse> postRequest({
    String? endpoint,
    Map<String, dynamic>? query,
    bool isProtected = true,
    Object? requestBody,
  }) async {
    try {
      final response = await _dio.post(
        endpoint ?? '',
        queryParameters: query,
        data: requestBody,
        options: Options(headers: isProtected ? await _fetchHeaders() : null),
      );

      return NetworkResponse.fromMap(response.data);
    } catch (e) {
      if (e is SocketException) {
        return NetworkResponse(
          status: false,
          message: 'Poor internet connection!',
          data: null,
        );
      } else if (e is DioException) {
        return NetworkResponse(
          status: false,
          message: e.message ?? 'An error occured',
          data: null,
        );
      }
      return NetworkResponse(status: false, message: e.toString(), data: null);
    }
  }

  Future<NetworkResponse> putRequest({
    String? endpoint,
    Map<String, dynamic>? query,
    bool isProtected = true,
    Object? requestBody,
  }) async {
    try {
      final response = await _dio.put(
        endpoint ?? '',
        queryParameters: query,
        data: requestBody,
        options: Options(headers: isProtected ? await _fetchHeaders() : null),
      );

      return NetworkResponse.fromMap(response.data);
    } catch (e) {
      if (e is SocketException) {
        return NetworkResponse(
          status: false,
          message: 'Poor internet connection!',
          data: null,
        );
      } else if (e is DioException) {
        return NetworkResponse(
          status: false,
          message: e.message ?? 'An error occured',
          data: null,
        );
      }
      return NetworkResponse(status: false, message: e.toString(), data: null);
    }
  }

  Future<NetworkResponse> deleteRequest({
    String? endpoint,
    Map<String, dynamic>? query,
    bool isProtected = true,
    Object? requestBody,
  }) async {
    try {
      final response = await _dio.delete(
        endpoint ?? '',
        queryParameters: query,
        data: requestBody,
        options: Options(headers: isProtected ? await _fetchHeaders() : null),
      );

      return NetworkResponse.fromMap(response.data);
    } catch (e) {
      if (e is SocketException) {
        return NetworkResponse(
          status: false,
          message: 'Poor internet connection!',
          data: null,
        );
      } else if (e is DioException) {
        return NetworkResponse(
          status: false,
          message: e.message ?? 'An error occured',
          data: null,
        );
      }
      return NetworkResponse(status: false, message: e.toString(), data: null);
    }
  }

  Future<NetworkResponse> requestWithFile({
    String? endpoint,
    Map<String, dynamic>? query,
    String fileName = '',
    DioMediaType? mimeType,
    List<int> fileBytes = const [],
    bool isProtected = true,
    Object? otherFieldsInRequest,
  }) async {
    try {
      final baseHeaders = isProtected ? await _fetchHeaders() : {};

      final Map<String, dynamic> multipartHeaders = {
        ...baseHeaders,
        'Content-Type': 'multipart/form-data',
      };

      // Check if we're using the old pattern (with fileName and fileBytes) or
      // directly passing FormData fields in otherFieldsInRequest
      FormData formData;
      if (fileBytes.isNotEmpty && fileName.isNotEmpty) {
        // Legacy usage with fileName and fileBytes parameters
        formData = FormData.fromMap({
          ...?(otherFieldsInRequest as Map?),
          fileName: MultipartFile.fromBytes(
            fileBytes,
            filename: fileName,
            contentType: mimeType,
          ),
        });
      } else {
        // New usage - otherFieldsInRequest already contains all form fields and files
        formData = FormData.fromMap(
          otherFieldsInRequest as Map<String, dynamic>? ?? {},
        );
      }

      logMessage('ApiService', 'FormData: ${formData.fields}');
      logMessage('ApiService', 'Files: ${formData.files}');
      final response = await _dio.post(
        endpoint ?? '',
        queryParameters: query,
        data: formData,
        options: Options(headers: multipartHeaders),
      );

      return NetworkResponse.fromMap(response.data);
    } catch (e) {
      if (e is SocketException) {
        return NetworkResponse(
          status: false,
          message: 'Poor internet connection!',
          data: null,
        );
      } else if (e is DioException) {
        return NetworkResponse(
          status: false,
          message: e.message ?? 'An error occured',
          data: null,
        );
      }
      return NetworkResponse(status: false, message: e.toString(), data: null);
    }
  }

  Future<Map<String, String>> _fetchHeaders() async {
    final token =
        await getIt<SecureStorageService>().readData(AppStrings.token) ?? '';
    return {'Authorization': 'Bearer $token'};
  }
}
