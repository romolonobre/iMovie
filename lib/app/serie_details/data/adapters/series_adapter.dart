import 'package:imovie_app/app/commons/entity_adaptor.dart';

import '../../../commons/helper.dart';
import '../../../commons/utils.dart';
import '../../../series/interactor/entities/series.dart';

class SerieAdapter extends EntityAdaptor<Serie> {
  @override
  Serie fromJson(json) {
    return Serie(
        id: Helper.getString(json["id"]),
        name: Helper.getString(json["original_name"]),
        description: Helper.getString(json["overview"]),
        releaseDate: Helper.getString(json["first_air_date"]),
        backgroundImage: imageBasePath + Helper.getString(json["backdrop_path"]),
        postImage: imageBasePath + Helper.getString(json["poster_path"]));
  }

  @override
  List<Serie> fromJsonToList(json) {
    if (json == null) return [];
    List<Serie> series = [];

    json['results'].forEach((e) {
      final Serie movie = SerieAdapter().fromJson(e);
      series.add(movie);
    });
    return series;
  }

  @override
  Map<String, dynamic> toMap(Serie value) {
    // TODO: implement toMap
    throw UnimplementedError();
  }
}
