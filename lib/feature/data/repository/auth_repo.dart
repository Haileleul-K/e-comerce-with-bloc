
import 'package:dartz/dartz.dart';
import 'package:ecommerce_test/core/error/failure.dart';
import 'package:ecommerce_test/feature/data/datasource/auth_datasource.dart';
import 'package:ecommerce_test/feature/data/model/user_response.dart';

abstract class AuthRepository {
  Future<Either<Failure,dynamic>> Login({required Map<String,dynamic> loginData});
  Future<Either<Failure,UserResponse>> GetUserData();
} 


class AuthRepositoryImply extends AuthRepository {
  final AuthService authService;
  AuthRepositoryImply({required this.authService});

  @override
  Future<Either<Failure, dynamic>> Login({required Map<String,dynamic> loginData}) async {
    var response = await authService.login(loginData: loginData);
    return response.fold(
        (error) => Left(error), (rightResponse) => Right(rightResponse));
  }

  @override
  Future<Either<Failure, UserResponse>> GetUserData() async {
    var response = await authService.getUserData();
    return response.fold(
        (error) => Left(error), (rightResponse) => Right(rightResponse));
    
  }
}