import 'package:flutter_modular/flutter_modular.dart';
import 'package:imovie_app/app/_commons/app_services/env.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class PushNotifications {
  static Future<void> initialize() async {
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

    OneSignal.initialize(Env.oneSignalAPIKey);
    OneSignal.Notifications.requestPermission(true);

    OneSignal.Notifications.addClickListener(
      (event) {
        final data = event.notification.additionalData;
        String? value = data?["path"];

        if (value == null) {
          Modular.to.pushNamed("/home");
        }

        switch (value) {
          case "splashscreen":
            Modular.to.pushNamed("/$value");
            break;
          case "login":
            Modular.to.pushNamed("/$value");
            break;
        }
      },
    );
  }
}
