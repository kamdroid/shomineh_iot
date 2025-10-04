


import 'package:flutter/material.dart';
import 'package:shomineh/config/resources/Images.dart';
import 'package:shomineh/config/theme/AppTheme.dart';
import 'package:shomineh/src/ui/widgets/CustomSwitch.dart';
import 'package:shomineh/src/ui/widgets/Space.dart';

Widget selectableRow(
    {required String imageNAme,
      required String title,
      String info = "",
      bool isEnable = true,
      bool showSwitch = false,
      bool value = false,
      ValueChanged<bool>? onChanged,
      Function()? onTap}) =>
    Builder(builder: (context) {
      return GestureDetector(
        onTap: () {
          if(isEnable) {
            if (!showSwitch) {
              onTap?.call();
            }
          }
        },
        child: Container(
          height: 80,
          decoration: AppTheme.containerBorder(
              borderWidth: 0, color: AppTheme.colors.cardBackground, cornerCurve: 16),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
          child: Row(
            children: [
              Center(
                child: Container(
                    width: 48,
                    height: 48,
                    padding: const EdgeInsets.only(right: 12, left: 12, top: 12, bottom: 10),
                    decoration: AppTheme.containerBorder(
                        cornerCurve: 10, color: AppTheme.colors.iconBack),
                    child: Images.instance.getSizedImageSvg(imageNAme)),
              ),
              const Space(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: AppTheme.fonts.faRegularMd(),
                  ),
                  Space(
                    height: info.isNotEmpty ? 2 : 0,
                  ),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Visibility(
                      visible: info.isNotEmpty,
                      child: Text(
                        info,
                        style: AppTheme.fonts.faRegularMd(),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Visibility(
                visible: !showSwitch,
                child: Center(
                  child: Images.instance.getSizedImageSvg('back'),
                ),
              ),
              Visibility(
                visible: showSwitch,
                child: Center(
                  child: CustomSwitch(value: value, onChanged: onChanged, isEnable: isEnable,),
                ),
              ),
            ],
          ),
        ),
      );
    });