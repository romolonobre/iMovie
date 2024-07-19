import 'package:flutter/widgets.dart';

import '../../commons/flutter_widgets/hero_dialog/navigation_bottom_bar.dart';
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
      ],
    );
  }
}
