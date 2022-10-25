import 'package:auto_route/auto_route.dart';
import 'package:boilerplate/routers/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

/// `AutoTabsRouter.pageView` is a `PageView` that automatically manages its
/// children's routes and the `PageController`'s `initialPage`
/// and `viewportFraction` properties
class MainView extends StatelessWidget {
  // ignore: public_member_api_docs
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter.pageView(
      routes: const [HomeRoute()],
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
