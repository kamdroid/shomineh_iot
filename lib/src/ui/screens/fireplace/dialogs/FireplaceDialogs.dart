
import 'package:flutter/material.dart';
import 'package:shomineh/config/resources/Strings.dart';
import 'package:shomineh/config/theme/AppTheme.dart';
import 'package:shomineh/navigation/Navigation.dart';
import 'package:shomineh/src/ui/widgets/ButtonApp.dart';
import 'package:shomineh/src/ui/widgets/CustomSlider.dart';
import 'package:shomineh/src/ui/widgets/Space.dart';

class FireSound extends StatefulWidget {
  final int initValue;
  const FireSound({super.key, required this.initValue});

  @override
  State<StatefulWidget> createState() => _FireSound();
}

class _FireSound extends State<FireSound> {
  late double value;

  @override
  void initState() {
    super.initState();

    value = widget.initValue.toDouble() <= 0 ? 0 : widget.initValue.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTheme.containerBorder(color: AppTheme.colors.transparent),
      padding: const EdgeInsets.only(right: 36, left: 36, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            Strings.fireSound,
            style: AppTheme.fonts.faRegularMd(),
          ),
          const Space(
            height: 24,
          ),
          Align(
              alignment: Alignment.centerRight,
              child: Text(
                Strings.enterFireSoundVolume,
                style: AppTheme.fonts.faRegularXs(),
              )),
          const Space(
            height: 28,
          ),
          CustomSlider(
              min: 0,
              max: 100,
              imageLeft: 'volume_l',
              imageRight: 'volume_h',
              visibleHandler: false,
              decoration: AppTheme.containerBorder(
                cornerCurve: 8,
                borderWidth: 0,
                color:  AppTheme.colors.primaryColor,
              ),
              label: value.toString(),
              value: value,
              onChanged: (val) {
                value = val;
                setState(() {});
              }),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonApp(
                  width: 116,
                  height: 40,
                  textStyle: AppTheme.fonts.faRegularMd(),
                  backgroundColor: AppTheme.colors.black,
                  disableColor: AppTheme.colors.black,
                  decoration: AppTheme.containerBorder(
                      borderColor: AppTheme.colors.whiteColor,
                      borderWidth: 1,
                      cornerCurve: 100,
                      color: AppTheme.colors.dialogBackground),
                  text: Strings.later,
                  onButtonPressed: Navigation.instance.popFromStackNoContext,
                ),
                const Space(
                  width: 44,
                ),
                ButtonApp(
                  width: 116,
                  height: 40,
                  textStyle: AppTheme.fonts.faRegularMd(color: AppTheme.colors.black),
                  text: Strings.confirm,
                  backgroundColor: AppTheme.colors.whiteColor,
                  cornerCurve: 100,
                  decoration: AppTheme.containerBorder(
                      borderColor: AppTheme.colors.dialogBackground,
                      borderWidth: 1,
                      cornerCurve: 100,
                      color: AppTheme.colors.whiteColor),
                  onButtonPressed: () {
                    Navigation.instance.popFromStackNoContext(result: value.toInt());
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

//***********************************************************************
//***********************************************************************
//***********************************************************************

class FireLight extends StatefulWidget {
  final int initValue;
  const FireLight({super.key, required this.initValue});

  @override
  State<StatefulWidget> createState() => _FireLight();
}

class _FireLight extends State<FireLight> {
  late double value;

  @override
  void initState() {
    super.initState();

    value = widget.initValue.toDouble() <= 0 ? 0 : widget.initValue.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTheme.containerBorder(color: AppTheme.colors.transparent),
      padding: const EdgeInsets.only(right: 36, left: 36, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            Strings.fireLight,
            style: AppTheme.fonts.faRegularMd(),
          ),
          const Space(
            height: 24,
          ),
          Align(
              alignment: Alignment.centerRight,
              child: Text(
                Strings.enterFireLight,
                style: AppTheme.fonts.faRegularXs(),
              )),
          const Space(
            height: 28,
          ),
          CustomSlider(
              min: 0,
              max: 5,
              imageLeft: 'light_l',
              imageRight: 'light_h',
              visibleHandler: false,
              decoration: AppTheme.containerBorder(
                cornerCurve: 8,
                borderWidth: 0,
                color:  AppTheme.colors.primaryColor,
              ),
              label: value.toString(),
              value: value,
              onChanged: (val) {
                value = val;
                setState(() {});
              }),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonApp(
                  width: 116,
                  height: 40,
                  textStyle: AppTheme.fonts.faRegularMd(),
                  backgroundColor: AppTheme.colors.black,
                  disableColor: AppTheme.colors.black,
                  decoration: AppTheme.containerBorder(
                      borderColor: AppTheme.colors.whiteColor,
                      borderWidth: 1,
                      cornerCurve: 100,
                      color: AppTheme.colors.dialogBackground),
                  text: Strings.later,
                  onButtonPressed: Navigation.instance.popFromStackNoContext,
                ),
                const Space(
                  width: 44,
                ),
                ButtonApp(
                  width: 116,
                  height: 40,
                  textStyle: AppTheme.fonts.faRegularMd(color: AppTheme.colors.black),
                  text: Strings.confirm,
                  backgroundColor: AppTheme.colors.whiteColor,
                  cornerCurve: 100,
                  decoration: AppTheme.containerBorder(
                      borderColor: AppTheme.colors.dialogBackground,
                      borderWidth: 1,
                      cornerCurve: 100,
                      color: AppTheme.colors.whiteColor),
                  onButtonPressed: () {
                    Navigation.instance.popFromStackNoContext(result: value.toInt());
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
