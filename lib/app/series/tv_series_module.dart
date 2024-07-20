import 'package:flutter_modular/flutter_modular.dart';

import '../serie_details/ui/serie_details_screen.dart';
import 'data/series_datasource.dart';
import 'data/series_service.dart';
import 'interactor/serie_controller.dart';
import 'series_screen.dart';

class SeriesModule extends Module {
  @override
  void binds(i) {
    i.add(SeriesService.new);
    i.add(SeriesDatasource.new);
    i.add(SerieController.new);
  }

  @override
  void routes(r) {
    r.child("/", child: (context) => SeriesScreen());
    r.child("/serie-details", child: (context) => SerieDetailsScreen(serie: r.args.data));
  }
}
