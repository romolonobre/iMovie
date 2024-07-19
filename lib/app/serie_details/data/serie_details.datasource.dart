// ignore_for_file: control_flow_in_finally

import 'package:http/http.dart';
import 'package:imovie_app/app/commons/api_request.dart';

import '../../commons/error_handle.dart';
import '../../commons/tmdb_api_response.dart';

class SerieDetailsDatasource extends APIRequest {
  Future<TMDBApiResponse> getSeasons(String id, String seasonNumber) async {
    Response? response;
    try {
      response = await this.get("3/tv/$id/season/$seasonNumber");
    } catch (error, stackTrace) {
      Errorhandler.report(error, stackTrace, "getSeasons");
    } finally {
      return TMDBApiResponse(response);
    }
  }

  Future<TMDBApiResponse> getSeasonVideos(String id, String seasonNumber) async {
    Response? response;
    try {
      response = await this.get("3/tv/$id/season/$seasonNumber/videos");
    } catch (error, stackTrace) {
      Errorhandler.report(error, stackTrace, "getSeasonVideos");
    } finally {
      return TMDBApiResponse(response);
    }
  }
}
