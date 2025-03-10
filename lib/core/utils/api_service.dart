import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../errors/failures.dart';

class ApiService {
  final Dio dio;

  ApiService({Dio? dioInstance})
      : dio = dioInstance ??
            Dio(BaseOptions(
             baseUrl: 'http://10.0.2.2:5216/api/',
              connectTimeout: const Duration(milliseconds: 5000),
              receiveTimeout: const Duration(milliseconds: 3000),
            ));

  Future<Either<Failures, Response>> signIn(
      String email, String password, String endPoint) async {
    try {
      final response = await dio.post(
        endPoint,
        data: {'email': email, 'password': password},
      );
      return Right(response);
    } on DioException catch (e) {
      // Instead of throwing, return a Left with a failure.
      return Left(ServerFailure(e.response?.data['message'] ?? 'Sign in failed'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
