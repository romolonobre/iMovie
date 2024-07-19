import 'package:imovie_app/app/series/data/adapters/serie_details_adapter.dart';
import 'package:imovie_app/app/series/data/adapters/series_adapter.dart';
import 'package:imovie_app/app/series/data/series_datasource.dart';
import 'package:imovie_app/app/series/interactor/entities/serie_details.dart';
import 'package:imovie_app/app/series/interactor/entities/series.dart';
import 'package:imovie_app/app/series/interactor/series_states.dart';

class SeriesService {
  final datasource = SeriesDatasource();
  final Cache cache = Cache();

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
      final cachedDetails = cache.getDetails(id);
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
      cache.setDetails(id, data);

      return SerieDetailsLoadedState(details: data);
    } catch (e) {
      return SeriesErrorState(message: e.toString());
    }
  }
}

class Cache {
  Cache._internal();

  static final Cache _instance = Cache._internal();

  factory Cache() {
    return _instance;
  }
  List<Serie>? _seriesCache;
  // Cache storage for details
  final Map<String, SerieDetails> _detailsCache = {};

  // Method to get details from cache
  SerieDetails? getDetails(String key) {
    return _detailsCache[key];
  }

  // Method to set details in cache
  void setDetails(String id, SerieDetails details) {
    _detailsCache[id] = details;
  }

  // Method to get series from cache
  List<Serie>? getSeries() {
    return _seriesCache;
  }

  // Method to set series in cache
  void setSeries(List<Serie> series) {
    _seriesCache = series;
  }
}
