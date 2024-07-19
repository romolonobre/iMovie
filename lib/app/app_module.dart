import 'package:flutter_modular/flutter_modular.dart';
import 'package:imovie_app/app/login/login_module.dart';
import 'package:imovie_app/app/spash_screen.dart';

import 'home/home_module.dart';
import 'serie_details/interactor/serie_details_controller.dart';
import 'series/interactor/serie_controller.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    i.add(SerieController.new);
    i.add(SerieDetailsController.new);
  }

  @override
  void routes(r) {
    r.child("/splashscreen", child: (context) => const SplashScreen());
    r.module('/home', module: HomeModule());
    r.module('/login', module: LoginModule());
  }
}
