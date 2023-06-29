import 'dart:io';

import 'package:comicbookapp/core/error/exceptions.dart';
import 'package:comicbookapp/core/network/network_info.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

// ignore: depend_on_referenced_packages
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

typedef UploadProgressCallback = void Function(int count, int total);

abstract class HttpClient {
  Future<Response<dynamic>> get(String path,
      {Map<String, dynamic>? queryParameters});
}

class HttpClientImpl implements HttpClient {
  final NetworkInfo connection;
  late final BaseOptions _options;
  final String apiKey;

  HttpClientImpl({
    required this.connection,
    required this.apiKey,
  }) : _options = BaseOptions(
            contentType: Headers.jsonContentType,
            connectTimeout: const Duration(milliseconds: 25000),
            receiveTimeout: const Duration(milliseconds: 30000),
            queryParameters: {'api_key': apiKey});

  bool isNotValidResponse(int statusCode) =>
      statusCode != HttpStatus.ok && statusCode != HttpStatus.created;

  Future<Dio> _getDio() async {
    var dio = Dio(_options);

    if (kDebugMode) {
      dio.interceptors.add(PrettyDioLogger(
          requestBody: true,
          requestHeader: false,
          responseBody: true,
          responseHeader: false));
    }

    return dio;
  }

  @override
  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final dio = await _getDio();
      if (!await connection.isConnected) {
        throw const SocketException('');
      }
      final response = await dio.get(path, queryParameters: queryParameters);
      if (isNotValidResponse(response.statusCode!)) {
        throw ServerException(
            message: response.data['message'],
            statusCode: response.statusCode!);
      }
      return response;
    } on DioException catch (error) {
      throw ExceptionUtils.getExceptionFromStatusCode(error);
    }
  }
}
