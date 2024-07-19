import 'package:flutter/material.dart';

class PageIndicatorWidget extends StatelessWidget {
  final int currentPage;
  final int pages;

  const PageIndicatorWidget({
    required this.currentPage,
    required this.pages,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pages,
        (index) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: (index == currentPage) ? 18.0 : 8.0,
            height: 6.0,
            margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(4.0),
              color: (index == currentPage) ? Colors.white : Colors.white.withOpacity(0.6),
            ),
          );
        },
      ),
    );
  }
}
