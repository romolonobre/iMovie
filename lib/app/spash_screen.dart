import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:imovie_app/app/authentication/interactor/login_controller.dart';
import 'package:imovie_app/app/commons/app_services/utils.dart';
import 'package:imovie_app/app/commons/imovie_ui/iui_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final service = Modular.get<LoginController>();

  @override
  void initState() {
    super.initState();
    final user = service.getUser();
    //
    // Check if user is logged or not, if user is null it means the user is logged out
    final String navigatoPath = user != null ? "home" : "login";
    Future.delayed(const Duration(seconds: 2)).then((value) => Modular.to.navigate('/$navigatoPath/'));
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
                  "IMovie",
                  color: primaryColor,
                  fontsize: 50,
                  fontWeight: FontWeight.w800,
                ).animate().animate().fade().scale(delay: 500.ms)
              ],
            ),
          )
        ],
      ),
    );
  }
}
