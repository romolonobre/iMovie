import '../../commons/app_services/cache.dart';
import '../interactor/entities/serie_details.dart';
import '../interactor/series_states.dart';
import 'adapters/serie_details_adapter.dart';
import 'adapters/series_adapter.dart';
import 'series_datasource.dart';

class SeriesService {
  final SeriesDatasource datasource;

  SeriesService({required this.datasource});

  Future<SeriesState> getSeries() async {
    try {
      final response = await datasource.getSeries();

      if (response.hasError) {
        return SeriesErrorState(message: response.errorMessage);
      }

      final series = SerieAdapter().fromJsonToList(response.data);

      return SeriesLoadedState(series: series);
    } catch (e) {
      return SeriesErrorState(message: e.toString());
    }
  }

  Future<SeriesState> getDetails(String id) async {
    try {
      // Check if the genres are already cached
      final cachedDetails = Cache().getDetails(id);
      if (cachedDetails != null) {
        return SerieDetailsLoadedState(details: cachedDetails);
      }

      // If not cached, fetch from the datasource
      final response = await datasource.getDetails(id);

      if (response.hasError) {
        return SeriesErrorState(message: response.errorMessage);
      }
      final SerieDetails data = SerieDetailsAdapter().fromJson(response.data);

      // Cache the fetched genres
      Cache().setDetails(id, data);

      return SerieDetailsLoadedState(details: data);
    } catch (e) {
      return SeriesErrorState(message: e.toString());
    }
  }
}
