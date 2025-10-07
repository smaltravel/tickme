import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tickme/navigation/app_destinations.dart';

@RoutePage()
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) => AutoTabsRouter.tabBar(
        routes: AppDestinations.all.map((e) => e.info).toList(),
        builder: (context, child, controller) {
          final tabsRouter = AutoTabsRouter.of(context);

          return Scaffold(
            body: child,
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: tabsRouter.activeIndex,
              onTap: tabsRouter.setActiveIndex,
              items: AppDestinations.all
                  .map((e) => BottomNavigationBarItem(
                        icon: Icon(e.icon),
                        label: e.label(context),
                      ))
                  .toList(),
            ),
          );
        },
      );
}
