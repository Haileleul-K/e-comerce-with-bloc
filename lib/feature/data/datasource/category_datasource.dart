import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_test/core/error/failure.dart';
import 'package:ecommerce_test/feature/data/model/category_response.dart';
import 'package:ecommerce_test/feature/data/repository/category._repo.dart';
import 'package:flutter/material.dart';

import '../../../core/util/api_helper.dart';
import '../../../dependency_injection.dart';

class CategoryService {
  Future<Either<Failure, CategoryResponse>> getCategoryData() async {
    Response? response;

    try {
      response = await sl<ApiBaseHelper>().get('/categories');
      return Right(CategoryResponse.fromJson(response?.data));
    } catch (e, trackTrace) {
      if (e is DioError) {
        print('error from home is $e and from $trackTrace');
        return Left(Failure.fromJson(e.response?.data));
      } else {
        debugPrint("Error response below home : $e");
        return Left(Failure(
            ok: false,
            error: Error(code: 400, message: 'Error')));
      }
    }
  }
}