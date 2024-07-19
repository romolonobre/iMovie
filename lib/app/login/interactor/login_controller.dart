import 'package:flutter/material.dart';
import 'package:imovie_app/app/login/data/login_service.dart';
import 'package:imovie_app/app/login/interactor/login_state.dart';

class LoginController extends ValueNotifier<LoginState> {
  LoginController() : super(IdleState());

  final service = LoginService();

  Future<LoginState> login({required String usrname, required String password}) async {
    final result = await service.login(usrname, password);
    return result;
  }
}
