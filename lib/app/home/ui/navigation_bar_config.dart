import 'package:flutter/widgets.dart';
import 'package:imovie_app/app/_commons/remote_config/remote_config_visibility_widget.dart';

import '../../_commons/flutter_widgets/hero_dialog/navigation_bottom_bar.dart';
import '../../profile/ui/profile_screen.dart';
import '../../series/series_screen.dart';
import 'home_screen.dart';

class NavigationBarConfig extends StatelessWidget {
  const NavigationBarConfig({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationBottomBar(
      screens: [
        const HomeScreen(),
        SeriesScreen(),

        // We can use the RemoteConfigVisibilityWidget to show or not
        // the profile screen based on the remote config flag
        const RemoteConfigVisibilityWidget(
          rmKey: "showProfile",
          defaultValue: false,
          child: ProfileScreen(),
        )
      ],
    );
  }
}
