import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:imovie_app/app/commons/imovie_ui/iui_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // TODO: Need to add the check if user is logged, wait till login endpoint is fixed
    //
    Future.delayed(const Duration(seconds: 2)).then((value) => Modular.to.navigate('/login/'));
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
}
