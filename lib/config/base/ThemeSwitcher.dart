import 'package:flutter/material.dart';
import 'package:shomineh/config/theme/AppTheme.dart';
import 'package:shomineh/navigation/RouteGenerator.dart';

class ThemeSwitcher extends InheritedWidget {
  ThemeSwitcherWidgetState data;

  ThemeSwitcher({
    super.key,
    required this.data,
    required super.child,
  });

  static ThemeSwitcherWidgetState? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeSwitcher>()?.data;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return this != oldWidget;
  }
}

class ThemeSwitcherWidget extends StatefulWidget {
  final ThemeData initialTheme;
  final Widget child;

  const ThemeSwitcherWidget(
      {super.key, required this.initialTheme, required this.child});

  @override
  State<StatefulWidget> createState() => ThemeSwitcherWidgetState();
}

class ThemeSwitcherWidgetState extends State<ThemeSwitcherWidget> {
  ThemeData? themeData;

  void switchTheme(ThemeData theme) {
    themeData = theme;

    RouteGenerator.instance.stateKeysMap.forEach((item, key) {
      key.currentState?.updateScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    themeData = themeData ?? widget.initialTheme;
    AppTheme.setStatusBarColor();
    return ThemeSwitcher(
      data: this,
      child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeOut,
          child: widget.child),
    );
  }
}
