import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '_commons/app_services/cache.dart';
import '_commons/app_services/utils.dart';
import '_commons/entities/app_user.dart';
import '_commons/imovie_ui/iui_text.dart';
import '_commons/push_notifications/push_notifications.dart';
import 'authentication/interactor/login_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final controller = Modular.get<LoginController>();

  @override
  void initState() {
    super.initState();
    final user = controller.getUser();
    handleNavigation(user);
    Future(() async => await PushNotifications.initialize());
  }

  void handleNavigation(AppUser? user) {
    bool isLogged = controller.isLogged();

    final String navigatoPath = isLogged ? "home" : "login";
    bool isBiometricsAuthEnabled = Cache().isBiometricsEnabled() ?? false;

    if (!isLogged) {
      Modular.to.navigate('/login/');
    } else if (!isBiometricsAuthEnabled) {
      Future.delayed(const Duration(seconds: 2)).then((_) => Modular.to.navigate('/$navigatoPath/'));
    } else {
      Modular.to.navigate('/biometrics/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IUIText.title(
                  "FindIt",
                  color: primaryColor,
                  fontsize: 55,
                  fontWeight: FontWeight.w700,
                ).animate().animate().fade().scale(delay: 500.ms)
              ],
            ),
          )
        ],
      ),
    );
  }
}
