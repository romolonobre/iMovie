import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:imovie_app/app/authentication/data/firebase_auth_service.dart';
import 'package:imovie_app/app/commons/imovie_ui/iui_text.dart';
import 'package:imovie_app/app/commons/remote_config/remote_config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final service = Modular.get<FirebaseAuthService>();

  @override
  void initState() {
    super.initState();
    final user = service.getCurrentUser();
    final String navigatoPath = user != null ? "home" : "login";
    Future.delayed(const Duration(seconds: 2)).then((value) => Modular.to.navigate('/$navigatoPath/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/splash_background.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IUIText.title(
                  "IMovie",
                  color: Colors.white,
                  fontsize: 35,
                ),
                IUIText.heading(
                  "Find your favorite movies",
                  color: Colors.white,
                  fontsize: 20,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  String getInitialNavigationPath() {
    return CustomRemoteConfig().getValueOrDefault(key: "initialNavigationPath", defaultValue: "home");
  }
}
