import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:imovie_app/app/app.dart';
import 'package:imovie_app/app/app_module.dart';

import 'app/commons/utils.dart';

void main() {
  Modular.setNavigatorKey(navigatorKey);
  runApp(
    ModularApp(
      module: AppModule(),
      child: const App(),
    ),
  );
}
