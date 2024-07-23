// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:imovie_app/app/authentication/data/firebase_auth_service.dart';

import '../../commons/entities/app_user.dart';
import 'login_state.dart';

class LoginController {
  final FirebaseAuthService service;
  LoginController(this.service);

  // This controller utilizes the State Pattern to return
  // the appropriate state based on the response from Firebase.

  Future<LoginState> loginWithFirebase({required String email, required String password}) async {
    final result = await service.loginWithFirebase(email, password);
    return result;
  }

  Future<LoginState> registerWithFirebase({required String usrname, required String password}) async {
    final result = await service.registerWithFirebase(usrname, password);
    return result;
  }

  Future<LoginState> signOut() async {
    final result = await service.signOut();
    return result;
  }

  Future<void> updateUsername(String name) async {
    await service.updateUsername(name);
  }

  Future<void> updateProfileImage(String image) async {
    await service.updateProfileImage(image);
  }

  AppUser? getUser() => service.getCurrentUser();
}
