import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shomineh/di/DiHelper.dart';

class Images {
  static Images get instance => DiHelper.images;

  String getSvg(String image) => "assets/images/$image.svg";

  String get(String image) => "assets/images/$image.png";

  String get2(String image) {
    if (kIsWeb) {
      return "assets/images/$image.png";
    }
    return get("2.0x/$image");
  }

  String get3(String image) {
    if (kIsWeb) {
      return "assets/images/$image.png";
    }
    return get("3.0x/$image");
  }

  String getFullName(String image) => "assets/images/$image";

  Widget getImage(String image, {Key? key, Color? color}) => Image.asset(
        get(image),
        key: key,
        color: color,
        errorBuilder: (context, error, stack) {
          return getImageSvg(image, color: color, key: key);
        },
      );

  Widget getImageSized(String image,
          {Color? color, double? width, double? height, Key? key}) =>
      Image.asset(
        get(image),
        width: width,
        height: height,
        color: color,
        key: key,
        errorBuilder: (context, error, stack) {
          return getSizedImageSvg(image,
              color: color, width: width, height: height, key: key);
        },
      );


  Widget getImageSvg(String image, {Color? color, Key? key}) =>
      SvgPicture.asset(
        getSvg(image),
        key: key,
        color: color,
      );

  Widget getSizedImageSvg(String image,
          {double? width, double? height, Color? color, Key? key}) =>
      SvgPicture.asset(
        getSvg(image),
        width: width,
        height: height,
        key: key,
        color: color,
      );
}
