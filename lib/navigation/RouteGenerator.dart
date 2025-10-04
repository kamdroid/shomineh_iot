import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shomineh/common/Util.dart';
import 'package:shomineh/config/constants/Constants.dart';
import 'package:shomineh/di/DiHelper.dart';
import 'package:shomineh/navigation/Navigation.dart';
import 'package:shomineh/src/infrastructure/store/StoreUnit.dart';
import 'package:shomineh/src/ui/base/BaseStateHandler.dart';
import 'package:shomineh/src/ui/base/ScreenRouteBuilder.dart';
import 'package:shomineh/src/ui/screens/device_selection/DeviceListProvider.dart';
import 'package:shomineh/src/ui/screens/device_selection/DeviceListScreen.dart';
import 'package:shomineh/src/ui/screens/fireplace/FireplaceProvider.dart';
import 'package:shomineh/src/ui/screens/fireplace/FireplaceScreen.dart';
import 'package:shomineh/src/ui/screens/splash/SplashProvider.dart';

class RouteGenerator {
  final StoreUnit store;

  RouteGenerator(this.store);

  static RouteGenerator get instance => DiHelper.routeGenerator;

  List<SingleChildWidget> get providersList {
    return [
      ChangeNotifierProvider(create: (_) => SplashProvider()),
      ChangeNotifierProvider(create: (_) => DeviceListProvider(DiHelper.bluetoothRepository, DiHelper.locationRepository)),
      ChangeNotifierProvider(create: (_) => FireplaceProvider(DiHelper.bluetoothCommunicationRepository)),

    ];
  }

  Map<String, GlobalKey<BaseStateHandler>> stateKeysMap = {
    // MainScreen.tag: GlobalKey(),
  };

  Route<dynamic> getRoute(RouteSettings settings) {
    var routingData = settings.name;
    printMessage("routingData:$routingData");
    printMessage("*************************************");
    Widget route = Container();

    switch (routingData) {

      /*case HOME_SCREEN:
        route = MainScreen.open();
        break;*/

      default:

    }

    /*return MaterialPageRoute(
        builder: (context) {
          return route;
        },
        settings: settings);*/

    route = DeviceListScreen();

    return ScreenRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => route,
        transitionsBuilder:
            (context, animation, secondaryAnimation, child) {
          final Animation<double> curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          );

          return FadeTransition(
            opacity: curvedAnimation,
            child: child,
          );
        });
  }

  Future<void> gotoInitScreen() async {

    Navigation.instance.gotoNoContext(firstPage);
  }

  String get homePage => HOME_SCREEN;

  String get firstPage => LIST_SCREEN;
}
