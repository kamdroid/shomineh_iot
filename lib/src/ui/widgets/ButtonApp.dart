
import 'package:flutter/material.dart';
import 'package:shomineh/common/extensions.dart';
import 'package:shomineh/common/screen_size_helper.dart';
import 'package:shomineh/config/constants/Constants.dart';
import 'package:shomineh/config/theme/AppTheme.dart';

class ButtonApp extends StatelessWidget {
  final bool isEnable;
  final bool showLoading;
  final bool? enableText;
  final String text;
  final TextStyle? textStyle;
  final Function()? onButtonPressed;
  final Color? disableColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final double cornerCurve;
  final double pressedBlack;
  final double? loadingSize;
  final double? height;
  final double? width;
  final double? borderWidth;
  final EdgeInsetsGeometry? padding;
  final Alignment alignment;
  final Widget? icon;
  final Decoration? decoration;
  final Decoration? disableDecoration;

  final _opacity = 0.5;

  const ButtonApp(
      {super.key,
      required this.text,
      this.textStyle,
      this.isEnable = true,
      this.enableText,
      this.decoration,
      this.disableDecoration,
      this.onButtonPressed,
      this.showLoading = false,
      this.backgroundColor,
      this.disableColor,
      this.borderColor,
      this.cornerCurve = 12,
      this.pressedBlack = 0.15,
      this.padding = EdgeInsets.zero,
      this.loadingSize,
      this.height,
      this.icon,
      this.alignment = Alignment.center,
      this.width/*= ITEM_WIDTH*/,
      this.borderWidth});

  @override
  Widget build(BuildContext context) {

    final textStyleSelected = textStyle ?? AppTheme.fonts.faRegularXl(color: AppTheme.colors.whiteColor);

    // borderColor = borderColor ?? backgroundColor;
    const backOpacity = 1.0;

    final disColor = (disableColor ?? AppTheme.colors.deactiveColor).withValues(alpha: backOpacity);
    // final disBorder = (borderColor ?? backgroundColor).withOpacity(_opacity);

    final containerHeight = height ?? BUTTON_HEIGHT;
    final loadHeight = loadingSize ?? BUTTON_HEIGHT / 2;

    final textColor = textStyleSelected.color;

    final enable = isEnable && !showLoading;

    final bWidth = borderWidth ?? (borderColor.isNotNull ? 2 : 0);

    final mainColor = enable ? showLoading? disColor : (backgroundColor ?? AppTheme.colors.primaryColor) : disColor;

    double value = HSVColor.fromColor(mainColor).value - pressedBlack;

    if(value.isNegative){
      value += pressedBlack;
    }

    final highlightColor = HSVColor.fromColor(mainColor).withValue(value).toColor();



    return Container(
        padding: EdgeInsets.zero,
        height: containerHeight,
        constraints: BoxConstraints(maxWidth: ScreenSizeHelper.getWidthDeviceRelated() - 32),
        width: width,
        decoration:enable ?
        (decoration ?? AppTheme.containerBorderGradient(
          borderColor: showLoading
              ? disColor
              : (borderColor ?? AppTheme.colors.transparent),
          borderWidth: bWidth,
          cornerCurve: cornerCurve, colors: [AppTheme.colors.primaryColor, AppTheme.colors.accentColor],
        ))
            : (disableDecoration ?? AppTheme.containerBorder(
          borderColor: disColor,
          borderWidth: bWidth,
          cornerCurve: cornerCurve,
            color: mainColor
        )),
        child: MaterialButton(
            onPressed: enable ? onButtonPressed : null,
            // color: mainColor,
            elevation: 0,
            splashColor: AppTheme.colors.transparent,
            highlightColor: highlightColor,
            highlightElevation: 0,
            hoverElevation: 0,
            hoverColor: AppTheme.colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(cornerCurve)),
            child: Align(
              alignment: alignment,
              child: icon ?? Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text(
                    text,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textStyleSelected.copyWith(
                        color: (enable || (enableText ?? isEnable))
                            ? textColor
                            : textColor?.withValues(alpha: _opacity)),
                  )),
            )));
  }
}
