import 'dart:io';

import 'package:comicbookapp/core/error/error_response_model.dart';
import 'package:dio/dio.dart';

class ServerException implements Exception {
  final String? message;
  final int statusCode;
  const ServerException({required this.message, this.statusCode = 200});
}

class NetworkException implements Exception {}

class NotFoundException implements Exception {}

class ExceptionUtils {
  static Exception getExceptionFromStatusCode(DioException error) {
    if (error.error is IOException ||
        error.type == DioExceptionType.connectionTimeout) {
      return NetworkException();
    } else {
      return _throwByStatusCode(error);
    }
  }

  static Exception _throwByStatusCode(DioException error) {
    late int errorCode;
    //Check if response is a custom response or a default response
    try {
      errorCode = ErrorResponseModel.fromJson(error.response!.data).statusCode;
    } catch (_) {
      errorCode = error.response!.statusCode!;
    }

    try {
      switch (errorCode) {
        case 404:
          return NotFoundException();
        default:
          return ServerException(
              message: error.message, statusCode: error.response!.statusCode!);
      }
    } catch (_) {
      return ServerException(
          message: error.message, statusCode: error.response!.statusCode!);
    }
  }
}
