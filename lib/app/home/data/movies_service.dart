// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../interactor/entities/movie.dart';
import '../interactor/states/movies_state.dart';
import 'adapters/movie_adapter.dart';
import 'movies_datasource.dart';

class MoviesService {
  MoviesDatasource datasource;
  MoviesService({required this.datasource});

  Future<MoviesState> gelAll({required String endpoint}) async {
    try {
      final response = await datasource(endpoint: endpoint);

      if (response.hasError) {
        return MoviesErrorState(message: response.errorMessage);
      }

      List<Movie> movies = MovieAdapter().fromJsonToList(response.data);
      return MoviesLoadedState(movies: movies);
    } catch (e) {
      return MoviesErrorState(message: e.toString());
    }
  }
}
