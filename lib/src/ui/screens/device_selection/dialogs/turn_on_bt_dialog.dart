import 'package:flutter/material.dart';
import 'package:shomineh/config/resources/Strings.dart';
import 'package:shomineh/config/theme/AppTheme.dart';
import 'package:shomineh/navigation/Navigation.dart';
import 'package:shomineh/src/ui/widgets/ButtonApp.dart';
import 'package:shomineh/src/ui/widgets/Space.dart';

Widget turnOnMessageDialog({
  void Function()? onAction
}) =>
    Builder(builder: (context) {
      return Container(
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
              height: 24,
            ),

            Text(
              Strings.checkForTurningBTOn,
              style: AppTheme.fonts.faRegularMd(),
              textDirection: TextDirection.rtl,
            ),

            const Space(
              height: 24,
            ),
            ButtonApp(
              width: 116,
              height: 40,
              textStyle: AppTheme.fonts.faRegularMd(),
              text: Strings.search,
              cornerCurve: 100,
              onButtonPressed: () {
                Navigation.instance.popFromStackNoContext();
                onAction?.call();
              },
            ),
          ],
        ),
      );

    });