import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:imovie_app/app/commons/app_services/utils.dart';
import 'package:imovie_app/app/commons/extensions/extensions.dart';

import '../../commons/flutter_widgets/imovie_textform_field.dart';
import '../../commons/imovie_ui/iui_buttons.dart';
import '../../commons/imovie_ui/iui_text.dart';
import '../interactor/login_controller.dart';
import '../interactor/login_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final controller = Modular.get<LoginController>();
  bool isLoading = false;
  String? errorMessage;
  String email = '';
  String name = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          SizedBox(
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
                  "Register",
                  fontWeight: FontWeight.w700,
                  fontsize: 30,
                ),
                const SizedBox(height: 20),

                // Name input
                ImovieTextformField(
                  hintText: 'Name',
                  onChanged: (value) {
                    setState(() => name = value);
                  },
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

                // Register button
                IUIButtons.solid(
                    label: isLoading ? "Processing..." : "Register",
                    height: 40,
                    onPressed: () async {
                      onRegister();
                    }),
                if (errorMessage != null)
                  IUIText.heading(
                    errorMessage!,
                    color: Colors.red,
                  )
              ],
            ),
          ).paddingOnly(left: 20, right: 20),

          // Back button
          Positioned(
            top: 40,
            left: 10,
            child: IUIButtons.back(context),
          ),
        ],
      ),
    );
  }

  Future<void> onRegister() async {
    setState(() => isLoading = true);
    final state = await controller.register(usrname: email, password: password);

    if (state is AuthErrorState) {
      errorMessage = state.errorMessage;
      setState(() => isLoading = false);
      return;
    }
    await controller.updateUsername(name);
    setState(() => isLoading = false);
    Modular.to.pop();
  }
}
