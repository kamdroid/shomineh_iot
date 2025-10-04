import 'package:flutter/material.dart';
import 'package:shomineh/common/extensions.dart';
import 'package:shomineh/common/screen_size_helper.dart';
import 'package:shomineh/config/resources/Strings.dart';
import 'package:shomineh/config/theme/AppTheme.dart';
import 'package:shomineh/di/DiHelper.dart';
import 'package:shomineh/navigation/Navigation.dart';

class Dialogs {
  static Dialogs get instance => DiHelper.dialogs;

  BuildContext context;

  Dialogs(this.context);

  void showExit({Function? action}) {
    showConfirm(Strings.exit, action: action);
  }

  void showConfirm(String title, {Function? action}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 5,
            title: Container(
              height: 40,
              alignment: Alignment.center,
              child: Text(title,
                  style: AppTheme.fonts.faMediumSm(color: AppTheme.colors.primaryColor)),
            ),
            content: Container(
              alignment: Alignment.centerRight,
              height: 50,
              child: Text(
                Strings.areYouSure,
                style: AppTheme.fonts.faMediumMd(color: AppTheme.colors.primaryColor),
              ),
            ),
            actions: [
              TextButton(
                child: Text(Strings.no),
                onPressed: () {
                  Navigation.instance.popFromStack(context);
                },
              ),
              TextButton(
                child: Text(Strings.yes),
                onPressed: () {
                  action?.call();
                },
              ),
            ],
          );
        });
  }

  void showMessage(String message, {String title = "", Function? action}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 5,
            title: Container(
              constraints: const BoxConstraints(minHeight: 40),
              alignment: Alignment.center,
              child: Text(title),
            ),
            content: Container(
              alignment: Alignment.centerRight,
              constraints: const BoxConstraints(minHeight: 50, maxHeight: 100),
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Directionality(
                      textDirection: TextDirection.rtl, child: Text(message))),
            ),
            actions: [
              TextButton(
                child: const Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(Strings.got_it)),
                onPressed: () {
                  Navigation.instance.popFromStack(context);
                  action?.call();
                },
              ),
            ],
          );
        });
  }

  void createDialog(
      {required Widget child, EdgeInsetsGeometry padding = EdgeInsets.zero}) {
    showGeneralDialog(
        context: context,
        barrierColor: AppTheme.colors.black.withOpacity(0.8),
        pageBuilder: (_, __, ___) {
          return Padding(
            padding: padding,
            child: Center(
              child: child,
            ),
          );
        });
  }

  void showDialogWithAnimation({
    required Widget child,
    bool barrierDismissible = true,
    Duration transitionDuration = Duration.zero,
  }) {
    showGeneralDialog(
      context: context,
      barrierColor: AppTheme.colors.black.withOpacity(0.8),
      barrierDismissible: barrierDismissible,
      transitionDuration: transitionDuration,
      barrierLabel: '',
      transitionBuilder: (context, a1, a2, widget) {
        return ScaleTransition(
          scale: Tween(begin: 0.5, end: 1.0).animate(a1),
          child: FadeTransition(
            opacity: Tween(begin: 0.5, end: 1.0).animate(a1),
            child: AlertDialog(
              alignment: Alignment.center,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              content: child,
            ),
          ),
        );
      },
      pageBuilder: (_, __, ___) {
        return const SizedBox();
      },
    );
  }

  Future<dynamic> createTransparentDialog(
      {required Widget child,
      bool isDismissible = true,
      AlignmentGeometry alignment = Alignment.topCenter,
      double topPadding = 200}) {
    return showDialog(
      context: context,
      barrierColor: Colors.black54.withOpacity(0.65),
      barrierDismissible: isDismissible,
      builder: (BuildContext context) => Theme(
        data: Theme.of(context)
            .copyWith(dialogBackgroundColor: Colors.transparent),
        child: AlertDialog(
          alignment: alignment,
          scrollable: true,
          contentPadding: EdgeInsets.only(top: topPadding),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          content: Padding(
            padding: const EdgeInsets.only(right: 12, left: 12),
            child: SizedBox(
              width: ScreenSizeHelper.getWidthDeviceRelated(),
              child: child,
            ),
          ),
        ),
      ),
    );
  }

  Future<T?> showBottomSheet<T>({
    required Widget child,
    double? minHeight,
    bool isDismissible = true,
    bool enableDrag = true,
    bool isScrollControlled = false,
    Color? backgroundColor,
    String? barrierLabel,
    double? elevation,
    ShapeBorder? shape,
    Clip? clipBehavior,
    BoxConstraints? constraints,
  }) {
    final boxConstraint = minHeight.isNull
        ? BoxConstraints(maxWidth: ScreenSizeHelper.getWidthDeviceRelated())
        : BoxConstraints(
            maxWidth: ScreenSizeHelper.getWidthDeviceRelated(), minHeight: minHeight!);

    return showModalBottomSheet(
        context: context,
        enableDrag: enableDrag,
        backgroundColor: backgroundColor ?? AppTheme.colors.dialogBackground,
        barrierLabel: barrierLabel,
        barrierColor: AppTheme.colors.black.withOpacity(0.8),
        elevation: elevation,
        shape: shape,
        isScrollControlled: isScrollControlled,
        showDragHandle: true,
        clipBehavior: clipBehavior,
        constraints: constraints ?? boxConstraint,
        isDismissible: isDismissible,
        builder: (context) {
          return SizedBox(height: minHeight, child: child);
        });
  }
}
