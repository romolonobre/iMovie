import 'package:flutter/material.dart';

import '../../commons/app_services/utils.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Container(),
    );
  }
}
