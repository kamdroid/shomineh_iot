import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shomineh/common/Util.dart';
import 'package:shomineh/common/extensions.dart';
import 'package:shomineh/common/screen_size_helper.dart';
import 'package:shomineh/config/constants/Constants.dart';
import 'package:shomineh/config/resources/Strings.dart';
import 'package:shomineh/config/theme/AppTheme.dart';
import 'package:shomineh/di/DiHelper.dart';
import 'package:shomineh/src/data/enums/SnackTypes.dart';

class Snack {
  static Snack get instance => DiHelper.snack;

  BuildContext context;

  Snack({required this.context});

  OverlayEntry? _overlayEntry;



  void showSnackCustomModalView(String message,
      {required BuildContext context,
        required SnackTypes type,
        bool usePersianFont = true,
        String? label,
        required Duration duration,
        TextStyle? style,
        double bottomSpace = 10,
        Function()? onPressed}) {
    final overlay = Overlay.of(context);

    hideModal();

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: type.isError ? null : bottomSpace,
        top: type.isError ? (headerHeight + 8) : null,
        left: 12,
        right: 12,
        child: SafeArea(
          child: SizedBox(
            width: ScreenSizeHelper.getWidthDeviceRelated(),
            child: Center(
              child: CustomSnackBarWidget(
                message: message,
                type: type,
                label: label,
                backgroundColor: AppTheme.colors.cardBackground,
                duration: duration,
                style: style,
                onPressed: onPressed,
                onDismiss: hideModal,
                usePersianFont: usePersianFont,
              ),
            ),
          ),
        ),
      ),
    );

    delaySafe(action: () {
      overlay.insert(_overlayEntry!);
    });
  }

  void hideModal() {
    if (_overlayEntry.isNotNull) {
      printMessage("******************* hide modal:${_overlayEntry.isNotNull}");
      _overlayEntry?.remove();
    }
    _overlayEntry = null;
  }
}

class CustomSnackBarWidget extends StatefulWidget {
  final SnackTypes type;
  final String? label;
  final String? topImage;
  final String message;
  final Color backgroundColor;
  final TextStyle? style;
  final Function()? onPressed;
  final Function() onDismiss;
  final Duration duration;
  final bool usePersianFont;

  const CustomSnackBarWidget({
    super.key,
    required this.message,
    required this.type,
    required this.duration,
    this.label,
    required this.usePersianFont,
    required this.backgroundColor,
    this.style,
    this.onPressed,
    this.topImage,
    required this.onDismiss,
  });

  @override
  State<StatefulWidget> createState() => _CustomSnackBarWidgetState();
}

class _CustomSnackBarWidgetState extends State<CustomSnackBarWidget>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Timer? _timer;
  Animation<Offset>? _slideAnimation;

  // late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..addStatusListener((status) {
        if (status.isDismissed) {
          widget.onDismiss.call();
          _controller = null;
          _timer = null;
        }
      });

    if (_controller.isNotNull) {
      _slideAnimation = Tween<Offset>(
        begin: Offset(widget.usePersianFont ? 1 : -1, 0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _controller!,
        curve: Curves.easeInOut,
      ));
    }

    _controller?.forward();

    _timer =
        delayDuration(duration: widget.duration, action: _reverseAnimation);
  }

  void _reverseAnimation() {
    printMessage("/////////////////// _reverseAnimation");
    _controller?.reverse();
    _timer?.cancel();
  }

  @override
  void dispose() {
    // _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_slideAnimation.isNotNull) {
      return SlideTransition(
        position: _slideAnimation!,
        child: _body,
      );
    } else {
      return _body;
    }
  }

  Widget get _body {

    Border border;
    if(widget.usePersianFont){
      border = Border(
        right:BorderSide(
          width: 4,
          color: widget.type.color,
        ),
      );
    } else {
      border = Border(
        left: BorderSide(
          width: 4,
          color: widget.type.color,
        ),
      );
    }


    return Directionality(
      textDirection:
      widget.usePersianFont ? TextDirection.rtl : TextDirection.ltr,
      child: Container(
        constraints: const BoxConstraints(minHeight: 48),
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(RadiusSize.rsm),
          border: border,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.message,
                style: widget.style ??
                    (widget.usePersianFont
                        ? AppTheme.fonts
                        .faMediumSm(color: AppTheme.colors.whiteColor)
                        : AppTheme.fonts
                        .enMediumSm(color: AppTheme.colors.whiteColor)),
                maxLines: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Visibility(
                      visible: widget.onPressed.isNotNull,
                      child: TextButton(
                        style: ButtonStyle(
                            overlayColor: WidgetStateProperty.all(
                                AppTheme.colors.primaryColor),
                            shape: WidgetStateProperty.all<
                                RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(4))))),
                        onPressed: () {
                          widget.onPressed?.call();
                          _reverseAnimation();
                        },
                        child: Text(
                          widget.label ?? (Strings.got_it),
                          style: AppTheme.fonts
                              .faBoldSm(color: AppTheme.colors.whiteColor),
                        ),
                      )),
                  Visibility(
                    visible: widget.duration.inSeconds > 10,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 14, left: 14),
                      child: TextButton(
                        style: ButtonStyle(
                            overlayColor: WidgetStateProperty.all(
                                widget.onPressed.isNotNull
                                    ? AppTheme.colors.primaryColor
                                    : AppTheme.colors.primaryColor),
                            shape: WidgetStateProperty.all<
                                RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(4))))),
                        onPressed: _reverseAnimation,
                        child: Text(
                          Strings.close,
                          textAlign: TextAlign.start,
                          style: AppTheme.fonts.faBoldSm(
                              color: widget.onPressed.isNotNull
                                  ? AppTheme.colors.whiteColor
                                  : AppTheme.colors.whiteColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
