import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_test/core/error/failure.dart';
import 'package:ecommerce_test/core/util/api_helper.dart';
import 'package:ecommerce_test/dependency_injection.dart';
import 'package:ecommerce_test/feature/data/model/user_response.dart';
import 'package:flutter/material.dart';

class AuthService {
  Future<Either<Failure, dynamic>> login(
      {required Map<String, dynamic> loginData}) async {
    Response? response;

    try {
      response =
          await sl<ApiBaseHelper>().post('/users/login', jsonEncode(loginData));
      return Right(response?.data);
    } catch (e, trackTrace) {
      if (e is DioError) {
        print('error $e and from $trackTrace');
        return Left(Failure.fromJson(e.response?.data));
      } else {
        return Left(Failure(
            ok: false,
            error: Error(code: 400, message: 'Error')));
      }
    }
  }


  Future<Either<Failure, UserResponse>> getUserData() async {
    Response? response;
    try {
      response =
          await sl<ApiBaseHelper>().get('/users');

   print(response?.data);
      return Right(UserResponse.fromJson(response?.data));
    } catch (e, trackTrace) {
      if (e is DioError) {
        print('error from userdata is $e and from $trackTrace');
        return Left(Failure.fromJson(e.response?.data));
      } else {
        debugPrint("Error response from userdata below : $e");
        return Left(Failure(
            ok: false,
            error: Error(code: 400, message: 'Error')));
      }
    }
  }
}
