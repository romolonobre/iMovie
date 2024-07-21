// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../interactor/login_state.dart';
import 'login_datasource.dart';

class TMDBLoginService {
  final LoginDatasource datasource;
  TMDBLoginService({required this.datasource});

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
    } catch (error) {
      return LoginErroState(errorMessage: error.toString());
    }
  }
}
