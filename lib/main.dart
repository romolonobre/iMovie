import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:imovie_app/app/app.dart';
import 'package:imovie_app/app/app_module.dart';
import 'package:imovie_app/firebase_options.dart';

import 'app/commons/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Modular.setNavigatorKey(navigatorKey);
  runApp(
    ModularApp(
      module: AppModule(),
      child: const App(),
    ),
  );
}
