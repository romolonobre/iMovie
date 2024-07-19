import 'package:flutter/material.dart';

import '../data/serie_details_service.dart';
import 'serie_details_state.dart';

class SerieDetailsController extends ValueNotifier<SerieDetailsState> {
  ValueNotifier<String> seasonNumber = ValueNotifier("1");
  SerieDetailsController() : super(IdleState());

  SerieDetailsService service = SerieDetailsService();

  Future getSeasons({required String id, required String seasonNumber}) async {
    _emit(SeriesDetailsLoadingState());
    final result = await service.getSeasons(id, seasonNumber);
    _emit(result);
  }

  Future getSeasonVideos({required String id, required String seasonNumber}) async {
    _emit(SeriesDetailsLoadingState());
    final result = await service.getSeasonVideos(id, seasonNumber);
    _emit(result);
  }

  void _emit(SerieDetailsState state) => value = state;
}
