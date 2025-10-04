
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:shomineh/common/screen_size_helper.dart';
import 'package:shomineh/config/resources/Strings.dart';
import 'package:shomineh/config/theme/AppTheme.dart';
import 'package:shomineh/navigation/Navigation.dart';
import 'package:shomineh/src/ui/widgets/ButtonApp.dart';

class ColorPickerDialogs extends StatefulWidget {
  final Color? initColor;


  const ColorPickerDialogs({this.initColor, super.key});

  @override
  State<StatefulWidget> createState() => _ColorPickerDialogs();
}

class _ColorPickerDialogs extends State<ColorPickerDialogs> {
  late Color currentColor;

  @override
  void initState() {
    super.initState();
    currentColor = widget.initColor ?? AppTheme.colors.primaryColor;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenSizeHelper.getWidthDeviceRelated() - 60,
      decoration: AppTheme.containerBorder(
        color: AppTheme.colors.cardBackground,
        cornerCurve: 12,
      ),
      padding: const EdgeInsets.only(bottom: 30,left: 30, right: 30, top: 20),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            ColorPicker(
                pickerColor: currentColor,
                paletteType: PaletteType.hueWheel,
                enableAlpha: false,
                displayThumbColor: false,
                hexInputBar: false,
                labelTypes: const [],
                onColorChanged: (color) {
                  currentColor = color;
                  setState(() {});
                }),
            Container(
              constraints: const BoxConstraints(maxHeight: 150),
            ),
            ButtonApp(
              textStyle: AppTheme.fonts.faRegularXl(),
              text: Strings.confirm,
              onButtonPressed: () {
                Navigation.instance.popFromStackNoContext(result: currentColor);
              },
            ),
          ],
        ),
      ),
    );
  }
}
