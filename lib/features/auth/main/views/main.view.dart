import 'package:auto_route/auto_route.dart';
import 'package:boilerplate/router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter.pageView(
      routes: const [HomeRoute(), LoginRoute()],
      builder: (context, child, pageController) {
        final tabsRouter = context.tabsRouter;
        return Scaffold(
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Ionicons.home),
                label: 'selam',
              ),
              BottomNavigationBarItem(icon: Icon(Ionicons.home), label: 'selam')
            ],
          ),
        );
      },
    );
  }
}
