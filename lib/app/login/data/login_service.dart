import 'dart:developer';

import 'package:imovie_app/app/login/data/login_datasource.dart';

import '../../commons/error_handle.dart';
import '../interactor/login_state.dart';

class LoginService {
  final datasource = LoginDatasource();

  Future<LoginState> login(String username, String password) async {
    try {
      final tokenResponse = await datasource.getRequestToken();

      if (tokenResponse.hasError) {
        return LoginErroState(errorMessage: tokenResponse.errorMessage);
      }
      final String token = tokenResponse.data["request_token"];

      final resposne = await datasource.login(username, password, token);

      if (resposne.hasError) {
        return LoginErroState(errorMessage: resposne.errorMessage);
      }
      return LoginSuccessState();
    } catch (error, stackTrace) {
      log(error.toString());
      Errorhandler.report(error, stackTrace, "@LoginService - login");
      return LoginErroState(errorMessage: error.toString());
    }
  }
}
