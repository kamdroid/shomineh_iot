import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:shomineh/common/screen_size_helper.dart';
import 'package:shomineh/config/resources/Strings.dart';
import 'package:shomineh/config/theme/AppTheme.dart';
import 'package:shomineh/navigation/Navigation.dart';
import 'package:shomineh/src/ui/widgets/ButtonApp.dart';
import 'package:shomineh/src/ui/widgets/DashLine.dart';
import 'package:shomineh/src/ui/widgets/Space.dart';

Widget connectToDialog({
  required ScanResult device,
  void Function()? onAction
}) =>
    Builder(builder: (context) {
      return Container(
        width: ScreenSizeHelper.getWidthDeviceRelated(),
        decoration: AppTheme.containerBorder(
          cornerCurve: 8,
            borderColor: AppTheme.colors.Grey,
            color: AppTheme.colors.dialogBackground),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Container(
              decoration: AppTheme.containerBorder(
                cornerCurve: 45,
                color: AppTheme.colors.blue
              ),
                padding: const EdgeInsets.all(12),
                child: Icon(Icons.bluetooth, size: 34, color: AppTheme.colors.whiteColor,)),
            const Space(
              height: 12,
            ),


            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: SizedBox(
                width: ScreenSizeHelper.getWidthDeviceRelated(),
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "platformName",
                      style: AppTheme.fonts.faMediumSm(
                          color: AppTheme.colors.whiteColor),
                    ),
                    const Space(),
                    const Expanded(child: DashLine()),
                    const Space(),
                    Text(
                      device.device.platformName,
                      style: AppTheme.fonts
                          .faRegularSm(color: AppTheme.colors.whiteColor),
                    ),
                  ],
                ),
              ),
            ),

            const Space(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: SizedBox(
                width: ScreenSizeHelper.getWidthDeviceRelated(),
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "advName",
                      style: AppTheme.fonts.faMediumSm(
                          color: AppTheme.colors.whiteColor),
                    ),
                    const Space(),
                    const Expanded(child: DashLine()),
                    const Space(),
                    Text(
                      device.device.advName,
                      style: AppTheme.fonts
                          .faRegularSm(color: AppTheme.colors.whiteColor),
                    ),
                  ],
                ),
              ),
            ),

            const Space(),

            const Space(
              height: 12,
            ),
            ButtonApp(
              width: 144,
              height: 40,
              textStyle: AppTheme.fonts.faRegularMd(),
              text: Strings.connectTo,
              onButtonPressed: () {
                Navigation.instance.popFromStackNoContext();
                onAction?.call();
              },
            ),
          ],
        ),
      );

    });