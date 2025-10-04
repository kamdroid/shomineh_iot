
import 'package:flutter/material.dart';
import 'package:shomineh/common/screen_size_helper.dart';
import 'package:shomineh/config/theme/AppTheme.dart';
import 'package:shomineh/src/ui/widgets/Space.dart';

class ColorPalletView extends StatelessWidget {
  final List<Color> colors;
  final int selectedIndex;
  final bool isEnable;
  final void Function(int)? onSelectColor;

  const ColorPalletView(
      {super.key,
      required this.colors,
      required this.selectedIndex,
      this.isEnable = true,
      this.onSelectColor});

  @override
  Widget build(BuildContext context) {
    final space = (ScreenSizeHelper.getWidthDeviceRelated() - 32 - 24 * (colors.length / 2)) /
        (colors.length / 2);

    List<Widget> row1 = List.from([
      Space(
        width: space / 2,
      )
    ], growable: true);
    List<Widget> row2 = List.from([
      Space(
        width: space / 2,
      )
    ], growable: true);

    for (int index = 0; index < colors.length; index++) {
      final view = GestureDetector(
        onTap: () {
          if(isEnable) {
            onSelectColor?.call(index);
          }
        },
        child: Container(
          width: 24,
          height: 24,
          decoration: AppTheme.containerBorder(
              color: (index != colors.length - 1)
                  ? colors[index]
                  : null,
              borderWidth: (selectedIndex == index) ? 2 : 0,
              borderColor: AppTheme.colors.whiteColor,
              cornerCurve: 100,
              gradient: (index != colors.length - 1)
                  ? null
                  : SweepGradient(colors: colors)),
          child: (index != colors.length - 1)
              ? const Space()
              : Center(
                  child: Text(
                    "A",
                    style: AppTheme.fonts.faBoldXs(),
                  ),
                ),
        ),
      );

      if (index < colors.length / 2) {
        row1.add(view);
        if (index != (colors.length / 2) - 1) {
          row1.add(Space(
            width: space,
          ));
        }
      } else {
        row2.add(view);
        if (index != colors.length - 1) {
          row2.add(Space(
            width: space,
          ));
        }
      }
    }

    return Container(
      width: ScreenSizeHelper.getWidthDeviceRelated(),
      height: 72,
      alignment: Alignment.center,
      child: Column(
        children: [
          Row(
            children: row1,
          ),
          const Spacer(),
          Row(
            children: row2,
          ),
        ],
      ),
    );
  }
}
