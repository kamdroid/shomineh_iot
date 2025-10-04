import 'package:flutter/material.dart';
import 'package:shomineh/common/Util.dart';
import 'package:shomineh/config/constants/Constants.dart';

class ScreenSizeHelper {
  ScreenSizeHelper._();

  static double getWidthDeviceRelated() {
    return isTargetPhone ? getWidth() : WIDTH_THRESHOLD;
  }

  static MediaQueryData getScreenDetail() => MediaQueryData.fromView(
      WidgetsBinding.instance.platformDispatcher.views.single);

// MediaQueryData getScreenDetail() => MediaQueryData.fromWindow(WidgetsBinding.instance.window);

  static double getWidth() {
    return getScreenDetail().size.width > WIDTH_THRESHOLD_MOBILE
      ? WIDTH_THRESHOLD_MOBILE
      :
        getScreenDetail().size.width;
  }

  static double getHeight() {
    final query = getScreenDetail();

    return query.size.height - query.viewPadding.top - query.viewPadding.bottom;
  }

  static double getResWidth({double any = 0}) {
    return getWidthDeviceRelated() - any;
  }

  static bool get screenIsPortrait{
    final data = MediaQueryData.fromView(
        WidgetsBinding.instance.platformDispatcher.views.single
    );

    return data.orientation == Orientation.portrait;
  }
}
