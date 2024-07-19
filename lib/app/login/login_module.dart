import 'package:flutter_modular/flutter_modular.dart';
import 'package:imovie_app/app/login/interactor/login_controller.dart';
import 'package:imovie_app/app/login/ui/login_screen.dart';

class LoginModule extends Module {
  @override
  void binds(Injector i) {
    i.add(LoginController.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const LoginScreen());
  }
}
