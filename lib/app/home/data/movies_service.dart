import 'package:imovie_app/app/home/data/adapters/movie_adapter.dart';
import 'package:imovie_app/app/home/data/movies_datasource.dart';

import '../interactor/entities/movie.dart';
import '../interactor/states/movies_state.dart';

class MoviesService {
  MoviesDatasource datasource = MoviesDatasource();

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
