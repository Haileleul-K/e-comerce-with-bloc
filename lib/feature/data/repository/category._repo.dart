import 'package:dartz/dartz.dart';
import 'package:ecommerce_test/core/error/failure.dart';
import 'package:ecommerce_test/feature/data/datasource/category_datasource.dart';
import 'package:ecommerce_test/feature/data/model/category_response.dart';

abstract class CategoryRepository {
  Future<Either<Failure,CategoryResponse>> getCatigoryData();
} 


class CategoryRepositoryImply extends CategoryRepository {
  final CategoryService categoryService;
  CategoryRepositoryImply({required this.categoryService});

  @override
  Future<Either<Failure, CategoryResponse>> getCatigoryData() async {
    var response = await categoryService.getCategoryData();
    return response.fold(
        (error) => Left(error), (rightResponse) => Right(rightResponse));
    
  }
}