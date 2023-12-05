part of 'auth_bloc.dart';

@immutable
class AuthState {}

class AuthInitial extends AuthState {}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {}

class LoginError extends AuthState {
  final String message;
  LoginError({required this.message});
}

class UserDataLoading extends AuthState {}

class UserDataLoaded extends AuthState {
  final UserResponse userData;
  UserDataLoaded({required this.userData});
}

class UserDataLoadingError extends AuthState {
  final String message;
  UserDataLoadingError({required this.message});
}
