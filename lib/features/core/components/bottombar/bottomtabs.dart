import 'package:boilerplate/core/theme/palette.dart';
import 'package:boilerplate/features/core/components/bottombar/bottom_navigation_tab.dart';
import 'package:flutter/material.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.transparent,
      elevation: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IntrinsicWidth(
            child: Container(
              padding: EdgeInsets.all(ThemePadding.low.padding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(ThemeRadius.medium.radius),
                color: ColorPalette.surface.color,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BottomNavigatorTab(
                    icon: Icons.home,
                    label: 'selam',
                    onPressed: () {
                      setState(() {
                        activeIndex = 0;
                      });
                    },
                    isActive: activeIndex == 0,
                  ),
                  BottomNavigatorTab(
                    icon: Icons.home,
                    label: 'selam',
                    onPressed: () {
                      setState(() {
                        activeIndex = 1;
                      });
                    },
                    isActive: activeIndex == 1,
                  ),
                  BottomNavigatorTab(
                    icon: Icons.abc,
                    label: 'selam',
                    onPressed: () {
                      setState(() {
                        activeIndex = 2;
                      });
                    },
                    isActive: activeIndex == 2,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
