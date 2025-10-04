
import 'package:flutter/material.dart';
import 'package:shomineh/config/resources/Images.dart';
import 'package:shomineh/config/theme/AppTheme.dart';

import 'Space.dart';

Widget temperatureView(
        {required double temperature, required String title}) =>
    Builder(builder: (context) {
      return SizedBox(
        width: 154,
        height: 154,
        child: Stack(
          children: [
            Images.instance.getSizedImageSvg(
              'circle_back',
              width: 164,
              height: 164,
            ),
            Center(
              child: Container(
                width: 110,
                height: 110,
                decoration: AppTheme.containerBorderGradient(
                    borderWidth: 0,
                    cornerCurve: 60,
                    colors: [
                      AppTheme.colors.gradient1,
                      AppTheme.colors.gradient2
                    ],
                    shadows: [
                      BoxShadow(
                          color: AppTheme.colors.shadow15Color,
                          spreadRadius: 0,
                          blurRadius: 33,
                          offset: const Offset(0, 29)),
                    ]),
                child: Column(
                  children: [
                    Text(
                      temperature.toInt().toString(),
                      style: AppTheme.fonts.faRegularMd().copyWith(fontSize: 40, shadows: [
                        Shadow(
                            color: AppTheme.colors.shadow15Color,
                            blurRadius: 4,
                            offset: const Offset(0, 4)),
                      ]),
                    ),
                    const Space(
                      height: 0,
                    ),
                    Text(
                      title,
                      style: AppTheme.fonts.faRegularXs(),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
