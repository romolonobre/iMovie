import 'package:flutter_modular/flutter_modular.dart';
import 'package:imovie_app/app/home/data/movies_datasource.dart';
import 'package:imovie_app/app/home/data/movies_service.dart';

import '../movie_details/movie_details_module.dart';
import '../serie_details/serie_details_module.dart';
import 'ui/navigation_bar_config.dart';

class HomeModule extends Module {
  @override
  void binds(Injector i) {
    i.add(MoviesDatasource.new);
    i.add(MoviesService.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const NavigationBarConfig());
    r.module('/details', module: MovieDetailsModule());
    r.module('/serie-details', module: SerieDetailsModule());
  }
}
