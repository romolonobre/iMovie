// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class LoginState {}

class IdleState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginErroState extends LoginState {
  final String errorMessage;
  LoginErroState({required this.errorMessage});
}
