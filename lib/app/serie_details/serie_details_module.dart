import 'package:flutter_modular/flutter_modular.dart';
import 'package:imovie_app/app/serie_details/interactor/serie_details_controller.dart';

import 'ui/serie_details_screen.dart';

class SerieDetailsModule extends Module {
  @override
  void binds(i) {
    i.add(SerieDetailsController.new);
  }

  @override
  void routes(r) {
    r.child("/serie-details", child: (context) => SerieDetailsScreen(serie: r.args.data));
  }
}
