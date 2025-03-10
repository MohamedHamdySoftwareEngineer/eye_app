

import 'dart:io';

import 'package:dio/dio.dart';

abstract class Failures {
  final String errorMessage;

  const Failures(this.errorMessage);
}

class ServerFailure extends Failures {
  ServerFailure(super.errorMessage);

  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection timeout with Apiserver');

      case DioExceptionType.sendTimeout:
        return ServerFailure('Send timeout with Apiserver');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('Recieve timeout with Apiserver');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            dioError.response!.statusCode!, dioError.response!.data);
      case DioExceptionType.cancel:
        return ServerFailure('Request to Apisever was canceld');
      case DioExceptionType.unknown:
        if (dioError.error is SocketException) {
    return ServerFailure('No Internet Connection');
  }
  return ServerFailure('Unexpected Error, Please try later.');
      default:
        return ServerFailure('Oops! There was an error!, Please try again.');
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(response['error']['message']);
    } else if (statusCode == 404) {
      return ServerFailure('Your request not found!,Please try later.');
    } else if (statusCode == 500) {
      return ServerFailure('Internal Server Error!,Please try later.');
    } else {
      return ServerFailure('Oops! There was an error!, Please try Later.');
    }
  }
}
