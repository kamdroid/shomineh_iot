


import 'package:flutter/material.dart';

class ScreenRouteBuilder extends PageRouteBuilder{

  static const int animationLength = 1000;

  @override
  Duration get transitionDuration => const Duration(milliseconds: animationLength ~/ 2);

  ScreenRouteBuilder({required super.pageBuilder, required super.transitionsBuilder});

}


class TransparentRoute extends PageRoute<void> {
  TransparentRoute({
    required this.builder,
    RouteSettings? settings,
  })  : assert(builder != null),
        super(settings: settings, fullscreenDialog: true);

  final WidgetBuilder builder;

  @override
  bool get opaque => false;

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    final result = builder(context);
    return FadeTransition(
      opacity: Tween<double>(begin: 0, end: 1).animate(animation),
      child: Semantics(
        scopesRoute: true,
        explicitChildNodes: true,
        child: result,
      ),
    );
  }
}