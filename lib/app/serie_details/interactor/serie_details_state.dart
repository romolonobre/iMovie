import 'entities/serie_season.dart';
import 'entities/serie_video.dart';

abstract class SerieDetailsState {}

class IdleState extends SerieDetailsState {}

class SeriesDetailsLoadingState extends SerieDetailsState {}

class SeriesDetailsErrorState extends SerieDetailsState {
  final String message;

  SeriesDetailsErrorState({required this.message});
}

class SerieSeasonLoadedState extends SerieDetailsState {
  final List<SerieSeason> seasons;

  SerieSeasonLoadedState({required this.seasons});
}

class SerieSeasonVideosLoadedState extends SerieDetailsState {
  final List<SerieVideo> videos;

  SerieSeasonVideosLoadedState({required this.videos});
}

class SerieSeasonVideosEmptyState extends SerieDetailsState {
  final List<SerieVideo> videos;

  SerieSeasonVideosEmptyState({required this.videos});
}
