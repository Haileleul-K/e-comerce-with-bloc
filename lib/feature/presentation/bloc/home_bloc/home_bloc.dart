import 'package:bloc/bloc.dart';
import 'package:ecommerce_test/feature/data/model/latest_products.dart';
import 'package:ecommerce_test/feature/data/repository/home_repo.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeRepository repository;
  HomeBloc(this.repository) : super(HomeInitial()) {
    on<GetLatestProducts>((event, emit) async {
      emit(HomeLoading());

      var response = await repository.getLatestProducts();

      response.fold(
          (failur) => emit(HomeError(message: failur.error.message??'Error happend')),
          (rightResponse) => emit(HomeLoaded(latestProductsResponse: rightResponse)));

    });
    
  }
}
