import '../../series/interactor/entities/serie_details.dart';

class Cache {
  Cache._internal();

  static final Cache _instance = Cache._internal();

  factory Cache() {
    return _instance;
  }

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
}
