import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shomineh/common/extensions.dart';
import 'package:shomineh/config/base/ThemeSwitcher.dart';
import 'package:shomineh/config/constants/Constants.dart';
import 'package:shomineh/config/theme/ThemeManager.dart';
import 'package:shomineh/config/theme/colors/baseColor.dart';
import 'package:shomineh/config/theme/colors/darkColors.dart';
import 'package:shomineh/config/theme/colors/lightColors.dart';
import 'package:shomineh/config/theme/fonts/fonts.dart';

class AppTheme {
  AppTheme._();

  static late BaseColor _colors;

  static BaseColor get colors => _colors;

  static late Fonts _fonts;

  static Fonts get fonts => _fonts;

  static ThemeData initTheme() {
    _colors = ThemeManager.instance.getThemeColors();

    _fonts = Fonts();
    setStatusBarColor();

    return _createThemeData();
  }

  static void setStatusBarColor(){

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: _colors.background,
        statusBarBrightness: ThemeManager.instance.themeIsDark() ? Brightness.light : Brightness.light,
        statusBarIconBrightness: ThemeManager.instance.themeIsDark() ? Brightness.light : Brightness.light));
  }

//*********************************************/ change Theme \**************************************************
  static void changeTheme(BuildContext context) {
    if (ThemeSwitcher.of(context).isNotNull) {
      final manager = ThemeManager.instance;

      final currentThemeIsDark = manager.themeIsDark();
      setTheme(context, !currentThemeIsDark);
    }
  }

  static void setTheme(BuildContext context, bool themeIsDark) {
    if (ThemeSwitcher.of(context).isNotNull) {
      final manager = ThemeManager.instance;

      manager.saveThemeState(themeIsDark);

      ThemeSwitcher.of(context)
          ?.switchTheme(themeIsDark ? createDarkTheme() : createLightTheme());
    }
  }

//*********************************************/ Themes \**************************************************
  static ThemeData createLightTheme() {
    _colors = LightColors();

    setStatusBarColor();

    return _createThemeData();
  }

  static ThemeData createDarkTheme() {
    _colors = DarkColors();

    setStatusBarColor();

    return _createThemeData();
  }

  static ThemeData _createThemeData() {
    return ThemeData(
        primarySwatch: colors.primaryColor.toMaterial,
        scaffoldBackgroundColor: colors.background,
        primaryColor: colors.background,
        fontFamily: 'sans',
        highlightColor: colors.primaryColor,
        textSelectionTheme: TextSelectionThemeData(
            selectionHandleColor: colors.primaryColor,
            cursorColor: colors.Grey),
        bottomSheetTheme: BottomSheetThemeData(
          dragHandleColor: colors.textColor,
          dragHandleSize: const Size(48, 4),
        )
        // backgroundColor: primaryColor
        );
  }

  //******************************* decoration ********************

  static BoxDecoration containerBorder({
    Color? color,
    Gradient? gradient,
    Color borderColor = Colors.black,
    List<BoxShadow>? shadows,
    double borderWidth = 1.0,
    double cornerCurve = 4.0,
    double? topRightCurve,
    double? topLeftCurve,
    double? bottomRightCurve,
    double? bottomLeftCurve,
    BoxBorder? border,
  }) {
    BoxBorder? borderBox;
    if (border.isNotNull) {
      borderBox = border;
    } else if (borderWidth > 0) {
      borderBox = Border.all(color: borderColor, width: borderWidth);
    }

    return BoxDecoration(
        color: color,
        gradient: gradient,
        border: borderBox,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(topRightCurve ?? cornerCurve),
            topLeft: Radius.circular(topLeftCurve ?? cornerCurve),
            bottomRight: Radius.circular(bottomRightCurve ?? cornerCurve),
            bottomLeft: Radius.circular(bottomLeftCurve ?? cornerCurve)),
        boxShadow: shadows);
  }

  static InputDecoration inputDecoration(
      {String hint = "",
      Color? backColor,
      bool? isDense,
      double lineWidth = 1.0,
      double cornerCurve = RadiusSize.rsm,
      String? labelText,
      TextStyle? hintStyle,
      TextStyle? labelStyle,
      InputBorder? border,
      InputBorder? focusedBorder,
      InputBorder? enabledBorder,
      Color? underlineColor,
      Widget? icon,
      EdgeInsetsGeometry? contentPadding}) {
    final defaultBorder = UnderlineInputBorder(
        borderRadius: BorderRadius.circular(cornerCurve),
        borderSide: BorderSide(
            color: underlineColor ?? colors.primaryColor, width: lineWidth));

    return InputDecoration(
        isDense: isDense,
        contentPadding: contentPadding,
        hintText: hint,
        labelText: labelText,
        labelStyle: labelStyle,
        fillColor: backColor,
        filled: true,
        hintStyle: hintStyle ?? _fonts.enMediumLg(),
        counterText: "",
        border: border ?? defaultBorder,
        suffixIcon: icon,
        focusedBorder: focusedBorder ?? defaultBorder,
        enabledBorder: enabledBorder ?? defaultBorder);
  }

  static InputDecoration outlineDecoration(
          {String hint = "",
          double bottom = -10,
          Color? backColor,
          TextStyle? hintStyle,
          Color focusedUnderlineColor = Colors.black,
          Color enableUnderlineColor = Colors.black}) =>
      InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(color: focusedUnderlineColor)),
          contentPadding: EdgeInsets.only(bottom: bottom),
          hintText: hint,
          fillColor: backColor,
          filled: backColor != null,
          hintStyle: hintStyle ?? _fonts.enMediumLg(),
          counterText: "",
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: focusedUnderlineColor)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: enableUnderlineColor)));

  static BoxDecoration containerBorderGradient({
    required List<Color> colors,
    Color? borderColor,
    double strokeAlign = BorderSide.strokeAlignInside,
    List<BoxShadow>? shadows = const [
      BoxShadow(
          color: Colors.transparent,
          spreadRadius: 0,
          blurRadius: 0,
          offset: Offset(0, 0))
    ],
    double borderWidth = 1.0,
    double cornerCurve = 0,
    double? topRightCurve,
    double? topLeftCurve,
    double? bottomRightCurve,
    double? bottomLeftCurve,
    AlignmentGeometry beginGradient = Alignment.topCenter,
    AlignmentGeometry endGradient = Alignment.bottomCenter,
  }) =>
      BoxDecoration(
          border: borderWidth == 0
              ? null
              : Border.all(
              color: borderColor ?? AppTheme.colors.black,
              width: borderWidth,
              strokeAlign: strokeAlign),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(topRightCurve ?? cornerCurve),
              topLeft: Radius.circular(topLeftCurve ?? cornerCurve),
              bottomRight: Radius.circular(bottomRightCurve ?? cornerCurve),
              bottomLeft: Radius.circular(bottomLeftCurve ?? cornerCurve)),
          gradient: LinearGradient(
              begin: beginGradient, end: endGradient, colors: colors),
          boxShadow: shadows);
}
