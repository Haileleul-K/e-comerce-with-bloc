part of 'auth_bloc.dart';

@immutable
 class AuthEvent {}


class LoginEvent extends AuthEvent{
  final String email;
  final String password;
  LoginEvent({required this.email,required this.password});
}

class GetUserData extends AuthEvent{
  final String token;
  GetUserData({required this.token});
}