import 'package:flutter_modular/flutter_modular.dart';

import 'data/login_datasource.dart';
import 'data/login_service.dart';
import 'interactor/login_controller.dart';
import 'ui/login_screen.dart';

class LoginModule extends Module {
  @override
  void binds(Injector i) {
    i.add(LoginDatasource.new);
    i.add(LoginService.new);
    i.add(LoginController.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const LoginScreen());
  }
}
