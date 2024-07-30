import 'package:flutter/material.dart';
import 'package:imovie_app/app/commons/extensions/extensions.dart';

class PlatformLoginButton extends StatelessWidget {
  final String icon;
  final Function ontap;
  const PlatformLoginButton(this.icon, {required this.ontap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ontap(),
      child: Container(
        height: 70,
        width: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 0.6,
            color: Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Image.asset(
          icon,
        ).paddingAll(20),
      ),
    );
  }
}
