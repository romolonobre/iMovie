import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:imovie_app/app/_commons/extensions/extensions.dart';
import 'package:imovie_app/app/_commons/imovie_ui/iui_snackbar.dart';
import 'package:imovie_app/app/_commons/imovie_ui/iui_text.dart';
import 'package:imovie_app/app/biometric/biometric_auth_state.dart';
import 'package:imovie_app/app/biometric/handle_biometric_auth.dart';
import 'package:lottie/lottie.dart';

import '../_commons/app_services/utils.dart';
import '../_commons/imovie_ui/iui_buttons.dart';

class BiometricAuthScreen extends StatefulWidget {
  const BiometricAuthScreen({super.key});

  @override
  State<BiometricAuthScreen> createState() => _BiometricAuthScreenState();
}

class _BiometricAuthScreenState extends State<BiometricAuthScreen> {
  final _auth = HandleBiometricAuthetication();

  @override
  void initState() {
    super.initState();
    Future(() => _handleAuht());
  }

  _handleAuht() async {
    final state = await _auth.authenticateWithBiometrics();
    if (!mounted) return;
    if (state is BiometricsAuthErrorState) {
      IUISnackbar.show(
        context,
        message: state.errorMessage,
        isError: true,
      );
      return;
    }
    if (state is BiometricsAuthSucessState) {
      Modular.to.navigate('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 100),

            // Lottie animation
            LottieBuilder.asset(
              'assets/images/biometric.json',
              height: 200,
            ),
            const Spacer(),

            // Button to manually authenticate using Biometrics if automatic authentication fails
            IUIButtons.text(
              label: "Tap to Log in with Biometrics",
              width: MediaQuery.sizeOf(context).width - 100,
              onPressed: () async => await _handleAuht(),
            ),

            // Button to navigate to the login screen if there is an issue with Biometrics
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IUIText.heading("Or Sign in again", fontsize: 13),
                const SizedBox(width: 10),
                InkWell(
                  onTap: () async => Modular.to.navigate('/login'),
                  child: IUIText.heading(
                    "Sign in",
                    color: primaryColor,
                    fontsize: 15,
                  ),
                ),
              ],
            ).paddingOnly(bottom: 40)
          ],
        ),
      ),
    );
  }
}
