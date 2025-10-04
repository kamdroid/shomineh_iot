

import 'package:flutter/material.dart';
import 'package:shomineh/config/resources/Urls.dart';

class Fonts{

  TextStyle lightFa(
      {required double fontSize,
        required Color color,
        double height = 1.6}) =>
      TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: fontSize,
          color: color,
          fontFeatures: const [FontFeature.proportionalFigures()],
          decoration: TextDecoration.none,
          height: height,
          fontFamily: Credential.yekan);

  TextStyle regularFa(
      {required double fontSize, Color? color, double height = 1.7}) =>
      TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: fontSize,
          color: color,
          fontFeatures: const [FontFeature.proportionalFigures()],
          decoration: TextDecoration.none,
          height: height,
          fontFamily: Credential.yekan);

  TextStyle regularEn(
      {required double fontSize,
        required Color color,
        double height = 1.6}) =>
      TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: fontSize,
          color: color,
          fontFeatures: const [FontFeature.proportionalFigures()],
          decoration: TextDecoration.none,
          height: height,
          fontFamily: Credential.yekan);

  TextStyle mediumFa(
      {required double fontSize, Color? color, double height = 1.6}) =>
      TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: fontSize,
          color: color,
          fontFeatures: const [FontFeature.proportionalFigures()],
          decoration: TextDecoration.none,
          height: height,
          fontFamily: Credential.yekan);

  TextStyle mediumEn(
      {required double fontSize,
        required Color color,
        double height = 1.6}) =>
      TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: fontSize,
          color: color,
          fontFeatures: const [FontFeature.proportionalFigures()],
          decoration: TextDecoration.none,
          height: height,
          fontFamily: Credential.yekan);

  TextStyle boldFa(
      {required double fontSize,
        Color? color,
        double height = 1.6}) =>
      TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
          color: color,
          fontFeatures: const [FontFeature.proportionalFigures()],
          decoration: TextDecoration.none,
          height: height,
          fontFamily: Credential.yekan);

  TextStyle boldEn(
      {required double fontSize,
        required Color color,
        double height = 1.6}) =>
      TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
          color: color,
          fontFeatures: const [FontFeature.proportionalFigures()],
          decoration: TextDecoration.none,
          height: height,
          fontFamily: Credential.yekan);


  TextStyle faLightXl({Color color = Colors.white}) => lightFa(height: 1.5, fontSize: 22, color: color);
  TextStyle faLightLg({Color color = Colors.white}) => lightFa(height: 1.5, fontSize: 18, color: color);
  TextStyle faLightMd({Color color = Colors.white}) => lightFa(fontSize: 16, color: color);
  TextStyle faLightSm({Color color = Colors.white}) => lightFa(fontSize: 14, color: color);
  TextStyle faLightXs({Color color = Colors.white}) => lightFa(fontSize: 12, color: color);
  TextStyle faLight2xs({Color color = Colors.white}) => lightFa(fontSize: 10, color: color);

  TextStyle faBoldXl({Color color = Colors.white}) => boldFa(height: 1.5, fontSize: 22, color: color);
  TextStyle faBoldLg({Color color = Colors.white}) => boldFa(height: 1.5, fontSize: 18, color: color);
  TextStyle faBoldMd({Color color = Colors.white}) => boldFa(fontSize: 16, color: color);
  TextStyle faBoldSm({Color color = Colors.white}) => boldFa(fontSize: 14, color: color);
  TextStyle faBoldXs({Color color = Colors.white}) => boldFa(fontSize: 12, color: color);
  TextStyle faBold2xs({Color color = Colors.white}) => boldFa(fontSize: 10, color: color);

  TextStyle faRegularXl({Color color = Colors.white}) =>  regularFa(fontSize: 22, height: 1.5, color: color);
  TextStyle faRegularLg({Color color = Colors.white}) =>  regularFa(fontSize: 18, height: 1.5, color: color);
  TextStyle faRegularMd({Color color = Colors.white}) =>  regularFa(fontSize: 16, color: color);
  TextStyle faRegularSm({Color color = Colors.white}) =>  regularFa(fontSize: 14, color: color);
  TextStyle faRegularXs({Color color = Colors.white}) =>  regularFa(fontSize: 12, color: color);
  TextStyle faRegular2xs({Color color = Colors.white}) => regularFa(fontSize: 10, color: color);

  TextStyle enRegularXl({Color color = Colors.white}) =>  regularEn(height: 1.5, fontSize: 22, color: color);
  TextStyle enRegularLg({Color color = Colors.white}) =>  regularEn(height: 1.5, fontSize: 18, color: color);
  TextStyle enRegularMd({Color color = Colors.white}) =>  regularEn(fontSize: 16, color: color);
  TextStyle enRegularSm({Color color = Colors.white}) =>  regularEn(fontSize: 14, color: color);
  TextStyle enRegularXs({Color color = Colors.white}) =>  regularEn(fontSize: 12, color: color);
  TextStyle enRegular2xs({Color color = Colors.white}) => regularEn(fontSize: 10, color: color);

  TextStyle faMediumXl({Color color = Colors.white}) =>  mediumFa(fontSize: 22, height: 1.5, color: color);
  TextStyle faMediumLg({Color color = Colors.white}) =>  mediumFa(fontSize: 18, height: 1.5, color: color);
  TextStyle faMediumMd({Color color = Colors.white}) =>  mediumFa(fontSize: 16, color: color);
  TextStyle faMediumSm({Color color = Colors.white}) =>  mediumFa(fontSize: 14, color: color);
  TextStyle faMediumXs({Color color = Colors.white}) =>  mediumFa(fontSize: 12, color: color);
  TextStyle faMedium2xs({Color color = Colors.white}) => mediumFa(fontSize: 10, color: color);

  TextStyle enMediumXl({Color color = Colors.white}) =>  mediumEn(height: 1.5, fontSize: 22, color: color);
  TextStyle enMediumLg({Color color = Colors.white}) =>  mediumEn(height: 1.5, fontSize: 18, color: color);
  TextStyle enMediumMd({Color color = Colors.white}) =>  mediumEn(fontSize: 16, color: color);
  TextStyle enMediumSm({Color color = Colors.white}) =>  mediumEn(fontSize: 14, color: color);
  TextStyle enMediumXs({Color color = Colors.white}) =>  mediumEn(fontSize: 12, color: color);
  TextStyle enMedium2xs({Color color = Colors.white}) => mediumEn(fontSize: 10, color: color);

  TextStyle enBoldXl({Color color = Colors.white}) => boldEn(height: 1.5, fontSize: 22, color: color);
  TextStyle enBoldLg({Color color = Colors.white}) => boldEn(height: 1.5, fontSize: 18, color: color);
  TextStyle enBoldMd({Color color = Colors.white}) => boldEn(fontSize: 16, color: color);
  TextStyle enBoldSm({Color color = Colors.white}) => boldEn(fontSize: 14, color: color);
  TextStyle enBoldXs({Color color = Colors.white}) => boldEn(fontSize: 12, color: color);
  TextStyle enBold2xs({Color color = Colors.white}) => boldEn(fontSize: 10, color: color);
  
}