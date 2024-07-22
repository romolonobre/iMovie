import 'package:flutter_modular/flutter_modular.dart';
import 'package:imovie_app/app/authentication/login_module.dart';
import 'package:imovie_app/app/spash_screen.dart';

import 'authentication/data/firebase_auth_service.dart';
import 'authentication/data/login_datasource.dart';
import 'authentication/interactor/login_controller.dart';
import 'home/home_module.dart';
import 'series/data/series_datasource.dart';
import 'series/data/series_service.dart';
import 'series/interactor/serie_controller.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    i.add(SeriesService.new);
    i.add(SeriesDatasource.new);
    i.add(SerieController.new);

    // Auth
    i.add(LoginDatasource.new);
    i.add(LoginController.new);
    i.add(FirebaseAuthService.new);
  }

  @override
  void routes(r) {
    r.child("/splashscreen", child: (context) => const SplashScreen());
    r.module('/home', module: HomeModule());
    r.module('/login', module: LoginModule());
  }
}
