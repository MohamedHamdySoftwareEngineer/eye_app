import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:eye/core/errors/failures.dart';
import 'package:eye/core/utils/api_service.dart';
import 'package:eye/features/sign_in/data/repos/sign_in_repo.dart';

class SignInRepoImpl implements SignInRepo {
  final ApiService apiService;

  SignInRepoImpl({required this.apiService});

  @override
  Future<Either<Failures, Response>> signIn(
      String email, String password, String endPoint) async {
    // Simply forward the result from ApiService.
    return await apiService.signIn(email, password, endPoint);
  }
}
