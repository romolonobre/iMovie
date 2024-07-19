import 'package:flutter_modular/flutter_modular.dart';

import '../movie_details/home_module.dart';
import 'ui/navigation_bar_config.dart';

class HomeModule extends Module {
  @override
  void binds(Injector i) {}

  @override
  void routes(RouteManager r) {
    r.module('/details', module: MovieDetailsModule());
    r.child('/', child: (context) => const NavigationBarConfig());
  }
}
