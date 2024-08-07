// ignore_for_file: control_flow_in_finally

import 'package:http/http.dart';
import 'package:imovie_app/app/_commons/app_services/api_request.dart';

import '../../_commons/app_services/error_handle.dart';
import '../../_commons/app_services/tmdb_api_response.dart';

class SerieDetailsDatasource extends APIRequest {
  Future<TMDBApiResponse> getSeasons(String id, String seasonNumber) async {
    Response? response;
    try {
      response = await this.get("3/tv/$id/season/$seasonNumber");
    } catch (error, stackTrace) {
      Errorhandler.report(error, stackTrace, tag: "@SerieDetailsDatasource getSeasons");
    } finally {
      return TMDBApiResponse(response);
    }
  }

  Future<TMDBApiResponse> getSeasonVideos(String id, String seasonNumber) async {
    Response? response;
    try {
      response = await this.get("3/tv/$id/season/$seasonNumber/videos");
    } catch (error, stackTrace) {
      Errorhandler.report(error, stackTrace, tag: "@SerieDetailsDatasource getSeasonVideos");
    } finally {
      return TMDBApiResponse(response);
    }
  }
}
