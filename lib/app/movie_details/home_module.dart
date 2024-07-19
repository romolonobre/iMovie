import 'package:flutter_modular/flutter_modular.dart';

import 'data/movie_details_service.dart';
import 'ui/movie_details_screen.dart';

class MovieDetailsModule extends Module {
  @override
  void binds(Injector i) {
    i.add(MovieDetailsService.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => MovieDetailsScreen(movie: r.args.data));
  }
}
