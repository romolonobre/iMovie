import 'package:flutter/material.dart';
import 'package:imovie_app/app/commons/utils.dart';

class NavigationBottomBar extends StatefulWidget {
  final List<Widget> screens;
  const NavigationBottomBar({super.key, required this.screens});

  @override
  State<NavigationBottomBar> createState() => _NavigationBottomBarState();
}

class _NavigationBottomBarState extends State<NavigationBottomBar> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff242226),
      bottomNavigationBar: SizedBox(
        child: Theme(
          data: ThemeData(
            navigationBarTheme: NavigationBarThemeData(
              indicatorColor: primaryColor,
              backgroundColor: Colors.black,
              labelTextStyle: MaterialStateProperty.resolveWith<TextStyle?>(
                (states) {
                  if (states.contains(MaterialState.selected)) {
                    return const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    );
                  }
                  return TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  );
                },
              ),
            ),
          ),
          child: NavigationBar(
            animationDuration: const Duration(seconds: 1),
            selectedIndex: selectedIndex,
            onDestinationSelected: (value) => setState(() => selectedIndex = value),
            destinations: const [
              NavigationDestination(
                  icon: Icon(
                    Icons.home_outlined,
                    size: 30,
                    color: Colors.white,
                  ),
                  label: "Home"),
              NavigationDestination(
                  icon: Icon(
                    Icons.tv,
                    color: Colors.white,
                  ),
                  label: "Tv Series"),
            ],
          ),
        ),
      ),
      body: widget.screens[selectedIndex],
    );
  }
}
