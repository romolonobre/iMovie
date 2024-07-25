import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:imovie_app/app/authentication/ui/register_screen.dart';
import 'package:imovie_app/app/commons/extensions/extensions.dart';

import '../../commons/app_services/utils.dart';
import '../../commons/flutter_widgets/imovie_textform_field.dart';
import '../../commons/imovie_ui/iui_buttons.dart';
import '../../commons/imovie_ui/iui_text.dart';
import '../interactor/login_controller.dart';
import '../interactor/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controller = Modular.get<LoginController>();

  bool isLoading = false;
  String? errorMessage;
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 100),
            Align(
              alignment: Alignment.center,
              child: IUIText.title(
                "IMovie",
                fontWeight: FontWeight.w700,
                fontsize: 60,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 50),
            IUIText.title(
              "Login",
              fontWeight: FontWeight.w700,
              fontsize: 30,
            ),
            const SizedBox(height: 20),

            // Email input
            ImovieTextformField(
              hintText: 'Email',
              onChanged: (value) {
                setState(() => email = value);
              },
            ),
            const SizedBox(height: 20),

            // Password input
            ImovieTextformField(
              hintText: "Password",
              isPasswordField: true,
              onChanged: (value) {
                setState(() => password = value);
              },
            ),
            const SizedBox(height: 30),

            // Login button
            IUIButtons.solid(
              label: isLoading ? "Processing..." : "Login",
              height: 40,
              onPressed: password.isNotEmpty && email.isNotEmpty ? () async => onLogin() : null,
            ),
            const SizedBox(height: 20),

            // Register button
            IUIButtons.solid(
                label: "Register",
                height: 40,
                onPressed: () async {
                  Modular.to.push(MaterialPageRoute(builder: (context) => const RegisterScreen()));
                }),

            // Error message
            if (errorMessage != null)
              IUIText.heading(
                errorMessage!,
                color: Colors.red,
              )
          ],
        ),
      ).paddingOnly(left: 20, right: 20),
    );
  }

  Future<void> onLogin() async {
    setState(() => isLoading = true);
    final state = await controller.login(email: email, password: password);
    if (state is AuthErrorState) {
      errorMessage = state.errorMessage;
      setState(() => isLoading = false);
      return;
    }
    if (state is LoginSuccessState) {
      setState(() => isLoading = false);
      Modular.to.navigate('/home');
    }
  }
}
