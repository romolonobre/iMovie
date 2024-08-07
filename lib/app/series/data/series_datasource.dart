// ignore_for_file: control_flow_in_finally

import 'package:http/http.dart';
import 'package:imovie_app/app/_commons/app_services/api_request.dart';

import '../../_commons/app_services/error_handle.dart';
import '../../_commons/app_services/tmdb_api_response.dart';

class SeriesDatasource extends APIRequest {
  Future<TMDBApiResponse> getSeries() async {
    Response? response;

    try {
      response = await this.get("3/tv/on_the_air");
    } catch (error, stackTrace) {
      Errorhandler.report(error, stackTrace, tag: "@SeriesDatasource getSeries");
    } finally {
      return TMDBApiResponse(response);
    }
  }

  Future<TMDBApiResponse> getDetails(String id) async {
    Response? response;
    try {
      response = await this.get("3/tv/$id");
    } catch (error, stackTrace) {
      Errorhandler.report(error, stackTrace, tag: "@SeriesDatasource getDetails");
    } finally {
      return TMDBApiResponse(response);
    }
  }
}
