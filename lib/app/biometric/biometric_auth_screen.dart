import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:imovie_app/app/_commons/imovie_ui/iui_buttons.dart';
import 'package:local_auth/local_auth.dart';
import 'package:lottie/lottie.dart';

import '../_commons/app_services/utils.dart';
import '../_commons/imovie_ui/iui_snackbar.dart';

class BiometricAuthScreen extends StatefulWidget {
  const BiometricAuthScreen({super.key});

  @override
  State<BiometricAuthScreen> createState() => _BiometricAuthScreenState();
}

class _BiometricAuthScreenState extends State<BiometricAuthScreen> {
  final LocalAuthentication _authentication = LocalAuthentication();
  String errorMessage = '';

  Future<void> authenticate() async {
    try {
      bool biometricsAvailable = await _checkBiometricsAvailability();
      if (biometricsAvailable) {
        bool authenticationSuccessful = await _authenticateWithBiometrics();
        if (!authenticationSuccessful) return;
        Modular.to.navigate('/home');
      }
    } on PlatformException catch (e) {
      setState(() => errorMessage = e.message ?? "An unexpected error has occurred");
    }
  }

  Future<bool> _authenticateWithBiometrics() async {
    return await _authentication.authenticate(
      localizedReason: "Please authenticate to access the app",
      options: const AuthenticationOptions(
        useErrorDialogs: true,
      ),
    );
  }

  Future<bool> _checkBiometricsAvailability() async {
    bool canCheckBiometrics = await _authentication.canCheckBiometrics;
    if (!canCheckBiometrics) {
      setState(() => errorMessage = "This device doesn't support biometrics or biometrics is not enabled.");
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieBuilder.asset(
              'assets/images/biometric.json',
              height: 200,
            ),
            IUIButtons.text(
                label: "Tap to Log in with Biometrics",
                width: MediaQuery.sizeOf(context).width - 100,
                onPressed: () async => await authenticate()),
            if (errorMessage.isNotEmpty) IUISnackbar.show(context, message: errorMessage),
          ],
        ),
      ),
    );
  }
}
