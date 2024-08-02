// ignore_for_file: control_flow_in_finally

import 'package:http/http.dart';
import 'package:imovie_app/app/_commons/app_services/api_request.dart';

import '../../_commons/app_services/error_handle.dart';
import '../../_commons/app_services/tmdb_api_response.dart';

class AuthDatasource extends APIRequest {
  // This endpoint is not working at the moment, all parameters are correct but
  // still returning "Invalid parameters: Your request parameters are incorrect."

  Future<TMDBApiResponse> login(String username, String password, String token) async {
    Response? response;
    try {
      response = await this.post(
        "3/authentication/token/validate_with_login",
        body: {
          "username": username,
          "password": password,
          "request_token": token,
        },
      );
    } catch (error, stackTrace) {
      Errorhandler.report(error, stackTrace, tag: "@LoginDatasource - login");
    } finally {
      return TMDBApiResponse(response);
    }
  }

  Future<TMDBApiResponse> getRequestToken() async {
    Response? response;
    try {
      response = await this.get("3/authentication/token/new");
    } catch (e, s) {
      Errorhandler.report(e, s, tag: '@LoginDatasource - getRequestToken');
    } finally {
      return TMDBApiResponse(response);
    }
  }
}
