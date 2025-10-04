
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shomineh/config/base/ThemeSwitcher.dart';
import 'package:shomineh/config/resources/Strings.dart';
import 'package:shomineh/config/resources/Urls.dart';
import 'package:shomineh/config/theme/AppTheme.dart';
import 'package:shomineh/config/theme/ThemeManager.dart';
import 'package:shomineh/di/DiHelper.dart';
import 'package:shomineh/navigation/Navigation.dart';
import 'package:shomineh/navigation/RouteGenerator.dart';
import 'package:shomineh/src/ui/screens/splash/SplashScreen.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await DiHelper.setupDi();

  final theme = AppTheme.initTheme();

  runApp(ThemeSwitcherWidget(
      initialTheme: theme,
      child: Builder(
          key: ValueKey(ThemeManager.instance.themeIsDark()
              ? Credential.darkTheme
              : Credential.lightTheme),
          builder: (context) => MultiProvider(
            providers: RouteGenerator.instance.providersList,
            child: MaterialApp(
              title: Strings.appName,
              theme: ThemeSwitcher.of(context)?.themeData,
              home: SplashScreen(),
              initialRoute: "/",
              onGenerateRoute: RouteGenerator.instance.getRoute,
              navigatorKey: Navigation.instance.navKey,
            ),
          )
      )));


}

