part of 'home_bloc.dart';

 class HomeState extends Equatable {
  const HomeState();
  
  @override
  List<Object> get props => [];
}

 class HomeInitial extends HomeState {}
class HomeLoading extends HomeState {}
class HomeLoaded extends HomeState {
  final LatestProductsResponse latestProductsResponse;
  const HomeLoaded({required this.latestProductsResponse});
}
class HomeError extends HomeState {
  final String message;
  const HomeError({required this.message});
}