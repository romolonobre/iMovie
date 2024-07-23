import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:imovie_app/app/commons/extensions/extensions.dart';

import '../../authentication/interactor/login_controller.dart';
import '../../authentication/interactor/login_state.dart';
import '../../commons/app_services/utils.dart';
import '../../commons/entities/app_user.dart';
import '../../commons/flutter_widgets/imovie_textform_field.dart';
import '../../commons/imovie_ui/iui_buttons.dart';
import '../../commons/imovie_ui/iui_modal.dart';
import '../../commons/imovie_ui/iui_text.dart';
import 'widgets/profile_image.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final controller = Modular.get<LoginController>();
  late AppUser? user;

  @override
  Widget build(BuildContext context) {
    user = controller.getUser();

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 220,
                    decoration: const BoxDecoration(color: primaryColor),
                  ),
                  Positioned(
                    bottom: -60,
                    right: 0,
                    left: 0,
                    child: Column(
                      children: [
                        IUIText.heading(
                          "Profile",
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontsize: 20,
                        ),
                        const SizedBox(height: 10),
                        CircleAvatar(
                          radius: 73,
                          child: CircleAvatar(
                            radius: 70,
                            child: ProfileAvatar(controller),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 80),

              // TODO: ADD FEATURE DO EDIT
              // Read only User name
              ImovieTextformField(
                initialValue: user?.name ?? '',
                isReadOnly: true,
              ).paddingOnly(left: 20, right: 20),

              // TODO: ADD FEATURE DO EDIT
              // Read only Email
              ImovieTextformField(
                isReadOnly: true,
                initialValue: user?.email ?? '',
              ).paddingOnly(left: 20, right: 20),
              const SizedBox(height: 20),
              IUIButtons.text(
                width: MediaQuery.sizeOf(context).width - 200,
                label: "Logout",
                onPressed: () => confirmLogoutModal(),
              )
            ],
          ),
        ),
      ),
    );
  }

  confirmLogoutModal() {
    IUIModal(navigatorKey.currentContext!,
        child: IUIText.heading(
          "Are you sure you want to logout?",
          color: Colors.black54,
          fontWeight: FontWeight.bold,
        ), onConfirm: () async {
      final state = await controller.signOut();
      if (state is SignOutState) {
        Modular.to.pushNamedAndRemoveUntil('/splashscreen', (p0) => true);
      }
    });
  }
}
