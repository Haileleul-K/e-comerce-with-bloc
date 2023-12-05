import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_test/core/error/failure.dart';
import 'package:ecommerce_test/core/util/api_helper.dart';
import 'package:ecommerce_test/dependency_injection.dart';
import 'package:ecommerce_test/feature/data/model/latest_products.dart';
import 'package:flutter/material.dart';

class HomeServies {
  Future<Either<Failure, LatestProductsResponse>> getLatestProducts() async {
    Response? response;

    try {
      response = await sl<ApiBaseHelper>().get('/products');
      return Right(LatestProductsResponse.fromJson(response?.data));
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
