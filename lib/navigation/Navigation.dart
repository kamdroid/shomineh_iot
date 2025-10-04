
import 'package:flutter/material.dart';
import 'package:shomineh/config/constants/Constants.dart';
import 'package:shomineh/di/DiHelper.dart';


class Navigation {

  static Navigation get instance => DiHelper.navigation;
  final navKey = GlobalKey<NavigatorState>();

  /// send user to /[PhoneScreen]
  void goOut() {
    goto(LIST_SCREEN);
  }

  /// use [route] as tag to move between screens when [context] is [not] available.
  void goto(String route) {
    navKey.currentState!.pushNamedAndRemoveUntil(route, (route) => false);
  }

  void gotoNoContext(String route) {
    navKey.currentState!.pushNamedAndRemoveUntil(route, (route) => false);
  }

  Future<T?> gotoWithRouteNoContext<T>(Widget route) {
    return navKey.currentState!.push(MaterialPageRoute(builder: (context) => route));
  }

  /// use [route] as tag to move between screens when [context] is available.
  void gotoScreenNoStack(BuildContext context, String route) {
    Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);
  }

  /// use [route] as tag to move between screens when [context] is available.Also put previous page in [stack] to call it later.
  void gotoScreenWithStack(BuildContext context, {required Widget route}) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));
  }

  void gotoScreenWithArguments(String route, Map id) {
    navKey.currentState!.pushNamed(route, arguments: id);
  }

  /// calls a screen from stack and show it again.
  void popFromStack<T>(BuildContext context, {T? result}) {
    Navigator.of(context).pop(result = result);
  }

  /// calls a screen from stack and show it again without context.
  void popFromStackNoContext<T>({T? result}) {
    navKey.currentState!.pop(result = result);
    // Navigator.of(navKey.currentState!.context).pop(result = result);
  }

  void popUntilRoute({required String route}) {
    navKey.currentState!.popUntil(ModalRoute.withName(route));
  }
}
