import 'package:firebase_auth/firebase_auth.dart';
import 'package:imovie_app/app/commons/entities/app_user.dart';

import '../../commons/app_services/error_handle.dart';
import '../interactor/login_state.dart';

class FirebaseAuthService {
  final _auth = FirebaseAuth.instance;

  // Login
  Future<LoginState> loginWithFirebase(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return result.user != null
          ? LoginSuccessState()
          : AuthErrorState(errorMessage: "Authentication failed. Please try again.");
    } on FirebaseAuthException catch (e) {
      return _handleFirebaseAuthException(e);
    } catch (e, s) {
      Errorhandler.report(e, s, tag: "loginWithFirebase");
      return AuthErrorState(errorMessage: "An unexpected error occurred");
    }
  }

  // Register
  Future<LoginState> registerWithFirebase(String email, String password) async {
    if (!_isPasswordStrong(password)) {
      return AuthErrorState(
        errorMessage:
            "Password must be at least 6 characters long and include an uppercase letter, a lowercase letter and a number",
      );
    }
    try {
      final result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return result.user != null
          ? RegisterSuccessState()
          : AuthErrorState(errorMessage: "Registration failed. Please try again.");
    } on FirebaseAuthException catch (e) {
      return _handleFirebaseAuthException(e);
    } catch (e, s) {
      Errorhandler.report(e, s, tag: "registerWithFirebase");
      return AuthErrorState(errorMessage: "An unexpected error occurred");
    }
  }

  // Update username
  Future<void> updateUsername(String name) async => await _auth.currentUser?.updateDisplayName(name);

  // Update Profile image
  Future<void> updateProfileImage(String image) async => await _auth.currentUser?.updatePhotoURL(image);

  // Get user
  AppUser? getCurrentUser() => _parseUser(_auth.currentUser);

  // Send email Verification
  Future<void> sendEmailVerification() async {
    if (_auth.currentUser != null) {
      await _auth.currentUser!.sendEmailVerification();
    }
  }

  // Signout
  Future<LoginState> signOut() async {
    await _auth.signOut();
    return SignOutState();
  }

  AppUser? _parseUser(User? user) {
    return user != null
        ? AppUser(
            userId: user.uid,
            email: user.email ?? '',
            isEmailVerifed: user.emailVerified,
            name: user.displayName ?? '',
            imageUrl: user.photoURL ?? '',
          )
        : null;
  }

  AuthErrorState _handleFirebaseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case "invalid-email":
        return AuthErrorState(errorMessage: "The email address is not valid. Please try again");
      case "user-disabled":
        return AuthErrorState(errorMessage: "This user account has been disabled");
      case "user-not-found":
        return AuthErrorState(errorMessage: "No user found with this email address. Please register first");
      case "wrong-password":
        return AuthErrorState(errorMessage: "Incorrect password. Please try again");
      case "email-already-in-use":
        return AuthErrorState(
            errorMessage: "An account with this email already exists. Please log in or use a different email");
      case "weak-password":
        return AuthErrorState(errorMessage: "The password is too weak. Please choose a stronger password");
      default:
        return AuthErrorState(errorMessage: "An error occurred (${e.code})");
    }
  }

  bool _isPasswordStrong(String password) {
    const minLength = 6;
    final hasUppercase = password.contains(RegExp(r'[A-Z]'));
    final hasLowercase = password.contains(RegExp(r'[a-z]'));
    final hasDigits = password.contains(RegExp(r'\d'));

    return password.length >= minLength && hasUppercase && hasLowercase && hasDigits;
  }
}
