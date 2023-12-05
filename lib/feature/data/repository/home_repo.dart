import 'package:dartz/dartz.dart';
import 'package:ecommerce_test/core/error/failure.dart';
import 'package:ecommerce_test/feature/data/datasource/home_datasource.dart';
import 'package:ecommerce_test/feature/data/model/latest_products.dart';

abstract class HomeRepository {
  Future<Either<Failure,LatestProductsResponse>> getLatestProducts();
} 


class HomeRepositoryImply extends HomeRepository {
  final HomeServies homeServies;
  HomeRepositoryImply({required this.homeServies});

  @override
  Future<Either<Failure, LatestProductsResponse>> getLatestProducts() async {
    var response = await homeServies.getLatestProducts();
    return response.fold(
        (error) => Left(error), (rightResponse) => Right(rightResponse));
    
  }
}