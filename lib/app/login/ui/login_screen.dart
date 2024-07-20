import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:imovie_app/app/commons/extensions/extensions.dart';

import '../../commons/flutter_widgets/imovie_textform_field.dart';
import '../../commons/imovie_ui/iui_buttons.dart';
import '../../commons/imovie_ui/iui_text.dart';
import '../../commons/utils.dart';
import '../interactor/login_controller.dart';
import '../interactor/login_state.dart';

// Login is not working at the moment, all parameters are correct but
// still returning "Invalid parameters: Your request parameters are incorrect."
// when hit "3/authentication/token/validate_with_login"

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controller = Modular.get<LoginController>();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String? errorMessage;
  String userName = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff242226),
      body: SizedBox(
        width: double.infinity,
        child: Form(
          key: _formKey,
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
              IUIText.heading(
                "Login with your TMDB credentials",
                fontWeight: FontWeight.w700,
                fontsize: 14,
                color: Colors.grey,
              ),
              const SizedBox(height: 20),
              ImovieTextformField(
                hintText: 'TMDB username',
                onChanged: (value) {
                  setState(() => userName = value);
                },
              ),
              const SizedBox(height: 20),
              ImovieTextformField(
                hintText: "TMDB password",
                onChanged: (value) {
                  setState(() => password = value);
                },
              ),
              const SizedBox(height: 30),
              IUIButtons.solid(
                label: isLoading ? "Processing.." : "Login",
                height: 40,
                onPressed: password.isNotEmpty && userName.isNotEmpty
                    ? () async {
                        if (_formKey.currentState!.validate()) {
                          Modular.to.navigate('/home');
                          // TODO: unconment this method when endpoint is fixed
                          // await onLogin();
                        }
                      }
                    : null,
              ),
              if (errorMessage != null)
                IUIText.heading(
                  errorMessage!,
                  color: Colors.red,
                )
            ],
          ),
        ),
      ).paddingOnly(left: 20, right: 20),
    );
  }

  Future<void> onLogin() async {
    setState(() => isLoading = true);
    final state = await controller.login(usrname: userName, password: password);
    if (state is LoginErroState) {
      errorMessage = state.errorMessage;
      setState(() => isLoading = false);
      return;
    }
    setState(() => isLoading = false);
    Modular.to.pushNamed('./home');
  }
}
