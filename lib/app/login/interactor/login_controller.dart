// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../data/login_service.dart';
import 'login_state.dart';

class LoginController {
  final LoginService service;
  LoginController(this.service);

  Future<LoginState> login({required String usrname, required String password}) async {
    final result = await service.login(usrname, password);
    return result;
  }
}
