import 'package:flutter_modular/flutter_modular.dart';

import 'data/serie_details.datasource.dart';
import 'data/serie_details_service.dart';
import 'interactor/serie_details_controller.dart';
import 'ui/serie_details_screen.dart';

class SerieDetailsModule extends Module {
  @override
  void binds(i) {
    i.add(SerieDetailsService.new);
    i.add(SerieDetailsDatasource.new);
    i.add(SerieDetailsController.new);
  }

  @override
  void routes(r) {
    r.child("/", child: (context) => SerieDetailsScreen(serie: r.args.data));
  }
}
