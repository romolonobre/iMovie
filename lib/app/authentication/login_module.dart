import 'package:flutter_modular/flutter_modular.dart';

import 'ui/login_screen.dart';

class LoginModule extends Module {
  @override
  void binds(Injector i) {}

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const LoginScreen());
  }
}
