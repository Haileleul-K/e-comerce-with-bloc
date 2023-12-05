import 'package:bloc/bloc.dart';
import 'package:ecommerce_test/feature/data/model/category_response.dart';
import 'package:ecommerce_test/feature/data/repository/category._repo.dart';
import 'package:equatable/equatable.dart';

part 'catagories_event.dart';
part 'catagories_state.dart';

class CatagoriesBloc extends Bloc<CatagoriesEvent, CatagoriesState> {
  CategoryRepository repository;
  CatagoriesBloc(this.repository) : super(CatagoriesInitial()) {
    on<GetCatigories>((event, emit) async {
      emit(CategoriesLoading());
      var response = await repository.getCatigoryData();
      response.fold((l) => emit(CategoriesError(message: l.error.message??'Error happend')), (r) => emit(CategoriesLoaded(categories: r)));
    });
  }
}
