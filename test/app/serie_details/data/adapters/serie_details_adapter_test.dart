import 'package:flutter_test/flutter_test.dart';
import 'package:imovie_app/app/serie_details/data/adapters/serie_season_adapter.dart';
import 'package:imovie_app/app/series/data/adapters/serie_details_adapter.dart';

void main() {
  group('SerieDetailsAdapter', () {
    test('fromJson returns a valid SerieDetails ', () {
      final adapter = SerieDetailsAdapter();
      final json = {
        "first_air_date": "2023-07-17",
        "vote_average": 8.5,
        "backdrop_path": "/image.jpg",
        "homepage": "https://example.com",
        "seasons": [
          {
            "air_date": "2023-07-17",
            "name": "Season 1",
            "overview": "This is the first season.",
            "still_path": "/image1.jpg",
            "vote_average": 8.5,
            "season_number": 1,
            "episode_count": 10,
            "episode_number": 1,
            "runtime": 60
          }
        ],
        "genres": [
          {"id": "1", "name": "Drama"},
          {"id": "2", "name": "Action"}
        ]
      };

      final details = adapter.fromJson(json);

      expect(details.releaseDate, '2023-07-17');
      expect(details.vote, 8.5);
      expect(details.postImage, '/image.jpg');
      expect(details.homePageLink, 'https://example.com');
      expect(details.seasons.length, 1);
      expect(details.genres.length, 2);
      expect(details.genres[0].id, '1');
      expect(details.genres[0].name, 'Drama');
      expect(details.genres[1].id, '2');
      expect(details.genres[1].name, 'Action');
    });

    test('fromJsonToList returns an empty list if json is null', () {
      final adapter = SerieDetailsAdapter();
      final seasons = adapter.fromJsonToList(null);

      expect(seasons, isEmpty);
    });

    test('fromJsonToList returns an empty list if "seasons" is not in json', () {
      final adapter = SerieDetailsAdapter();
      final json = {};

      final seasons = adapter.fromJsonToList(json);

      expect(seasons, isEmpty);
    });

    test('fromJson handles invalid data types gracefully', () {
      final adapter = SerieDetailsAdapter();
      final json = {
        "first_air_date": 12345,
        "vote_average": "2",
        "backdrop_path": null,
        "homepage": null,
        "seasons": SerieSeasonAdapter().fromJsonToList(null),
        "genres": [
          {"id": 2, "name": 1}
        ]
      };

      final details = adapter.fromJson(json);

      expect(details.releaseDate, '12345');
      expect(details.vote, 2);
      expect(details.postImage, '');
      expect(details.homePageLink, '');
      expect(details.seasons, []);
      expect(details.genres[0].id, '2');
      expect(details.genres[0].name, '1');
    });
  });
}
