import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/errors/failures.dart';

abstract class SignInRepo {
  Future<Either<Failures, Response>> signIn(String email, String password,String endPoint);
}