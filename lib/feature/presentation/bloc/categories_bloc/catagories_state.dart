part of 'catagories_bloc.dart';

 class CatagoriesState extends Equatable {
  const CatagoriesState();
  
  @override
  List<Object> get props => [];
}

 class CatagoriesInitial extends CatagoriesState {}

class CategoriesLoading extends CatagoriesState {}
class CategoriesLoaded extends CatagoriesState {
  final CategoryResponse categories;
  const CategoriesLoaded({required this.categories});
}

class CategoriesError extends CatagoriesState {
  final String message;
  const CategoriesError({required this.message});
}