import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

import 'biometric_auth_state.dart';

class HandleBiometricAuthetication {
  final LocalAuthentication _auth = LocalAuthentication();

  Future<BiometricsAuthState> authenticateWithBiometrics() async {
    try {
      bool canCheckBiometrics = await _auth.canCheckBiometrics;
      bool isAuthenticate = await _authenticate();

      // Check if the device is capable of checking biometrics, if not lets return BiometricsAuthErrorState
      if (!canCheckBiometrics) {
        return BiometricsAuthErrorState(
          errorMessage: "This device doesn't support biometrics",
        );
      }

      // If the user is successfully authenticated lest return BiometricAuthSucessState
      if (isAuthenticate) {
        return BiometricsAuthSucessState();
      }
    } on PlatformException catch (e) {
      return BiometricsAuthErrorState(errorMessage: e.message ?? "An unexpected error has occurred");
    }
    // Lest do nothing if the user is not autheticated
    return BiometricsIdleState();
  }

  Future<bool> _authenticate() async {
    return await _auth.authenticate(
      localizedReason: "Please authenticate to access the app",
      options: const AuthenticationOptions(
        useErrorDialogs: true,
      ),
    );
  }
}
