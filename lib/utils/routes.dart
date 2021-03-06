import 'package:flutter/material.dart';
import 'package:wall_hunt/layout/walli/dashboard_tabs.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/DashboardTabs': (BuildContext context) => DashboardTabs(),
};


class SlideRightRoute extends PageRouteBuilder {
  final Widget widget;
  SlideRightRoute({this.widget})
      : super(
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return widget;
      },
      transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
        return new SlideTransition(
          position: new Tween<Offset>(
            begin: const Offset(-1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      }
  );
}