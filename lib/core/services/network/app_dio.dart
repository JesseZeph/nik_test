import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:niklaar/core/constants/api_endpoints.dart';

class AppDio extends DioForNative {
  AppDio(BaseOptions super.options);
  factory AppDio.fromConfig() {
    final instance = AppDio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        contentType: Headers.formUrlEncodedContentType,
        connectTimeout: const Duration(seconds: 10),
        validateStatus: (status) => true,
      ),
    );
    instance.interceptors.add(_AppNetworkInterceptor());
    return instance;
  }
}

class _AppNetworkInterceptor extends Interceptor {
  @override
  onError(DioException err, ErrorInterceptorHandler handler) {
    log(
      "=========> Error with request: ${err.requestOptions.path} ============> \n status code: ${err.response?.statusCode}",
    );
    log("Headers: ${err.requestOptions.headers}");
    log("Data: ${err.requestOptions.data}");

    handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log(
      "=========> Response from request: ${response.requestOptions.path} ============> \n response: ${response.data} \n statusCode: ${response.statusCode},\n requestBody: ${response.requestOptions.data} ",
    );

    super.onResponse(response, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log("=========> Full Request details for: ${options.path} ============>");
    // log("Method: ${options.method}");
    // log("Base URL: ${options.baseUrl}");
    // log("Full URL: ${options.uri}");
    // log("Headers: ${options.headers}");
    // log("Data: ${options.data}");
    handler.next(options);
  }
}
