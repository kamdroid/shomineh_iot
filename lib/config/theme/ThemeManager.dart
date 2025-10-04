import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shomineh/common/Util.dart';
import 'package:shomineh/config/resources/Urls.dart';
import 'package:shomineh/config/theme/colors/baseColor.dart';
import 'package:shomineh/config/theme/colors/darkColors.dart';
import 'package:shomineh/config/theme/colors/lightColors.dart';
import 'package:shomineh/di/DiHelper.dart';
import 'package:shomineh/src/infrastructure/store/StoreUnit.dart';

class ThemeManager {
  static ThemeManager get instance => DiHelper.themeManager;

  final StoreUnit storeUnit;

  ThemeManager(this.storeUnit);

  BaseColor getThemeColors() {
    return themeIsDark() ? DarkColors() : LightColors();
  }

  void saveThemeState(bool isDarkTheme) {
    storeUnit
        .setTheme(isDarkTheme ? Credential.darkTheme : Credential.lightTheme);
  }

  bool themeIsDark() {
    String theme = storeUnit.getTheme();
    switch (theme) {
      case '':
        var brightness =
            SchedulerBinding.instance.platformDispatcher.platformBrightness;
        printMessage(
            "/////////////////////// isDarkMode:${brightness == Brightness.dark}");

        return brightness == Brightness.dark;

      case Credential.lightTheme:
        return false;
      default:
        return true;
    }
  }
}
