// ignore_for_file: control_flow_in_finally

import 'package:http/http.dart';
import 'package:imovie_app/app/commons/error_handle.dart';

import '../../commons/api_request.dart';
import '../../commons/tmdb_api_response.dart';

class MovieDetailsDatasource extends APIRequest {
  Future<TMDBApiResponse> _fetchData(String endpoint, {required String tag}) async {
    Response? response;
    try {
      response = await this.get(endpoint);
    } catch (error, stackTrace) {
      Errorhandler.report(error, stackTrace, tag);
    } finally {
      return TMDBApiResponse(response);
    }
  }

  Future<TMDBApiResponse> getGenres({required String id}) async {
    return await _fetchData("3/movie/$id", tag: "getGenres");
  }

  Future<TMDBApiResponse> getCast({required String id}) async {
    return await _fetchData("3/movie/$id/credits", tag: "getCast");
  }

  Future<TMDBApiResponse> getVideos({required String id}) async {
    return await _fetchData("3/movie/$id/videos", tag: "getVideos");
  }

  Future<TMDBApiResponse> getPhotos({required String id}) async {
    return await _fetchData("3/movie/$id/images", tag: "getPhotos");
  }

  Future<TMDBApiResponse> getreviews({required String id}) async {
    return await _fetchData("3/movie/$id/reviews", tag: "getreviews");
  }
}
