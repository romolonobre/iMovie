import 'package:imovie_app/app/commons/app_services/entity_adaptor.dart';

import '../../../commons/app_services/helper.dart';
import '../../../movie_details/interactor/entities/genres.dart';
import '../../../serie_details/data/adapters/serie_season_adapter.dart';
import '../../interactor/entities/serie_details.dart';

class SerieDetailsAdapter extends EntityAdaptor<SerieDetails> {
  @override
  SerieDetails fromJson(json) {
    return SerieDetails(
      releaseDate: Helper.getString(json["first_air_date"]),
      vote: Helper.getDouble(json["vote_average"]),
      postImage: Helper.getString(json["backdrop_path"]),
      homePageLink: Helper.getString(json["homepage"]),
      seasons: SerieSeasonAdapter().fromJsonToList(json),
      genres: _parseGenres(json["genres"]),
    );
  }

  _parseGenres(json) {
    if (json == null) return [];
    List<Genre> genres = [];
    json.forEach((e) {
      final Genre genre = Genre(
        id: Helper.getString(e["id"]),
        name: Helper.getString(e["name"]),
      );
      genres.add(genre);
    });
    return genres;
  }

  @override
  List<SerieDetails> fromJsonToList(json) => [];

  @override
  Map<String, dynamic> toMap(SerieDetails value) => {};
}
