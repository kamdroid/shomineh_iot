import 'package:flutter/material.dart';
import 'package:shomineh/common/Util.dart';
import 'package:shomineh/common/extensions.dart';
import 'package:shomineh/common/screen_size_helper.dart';
import 'package:shomineh/config/theme/AppTheme.dart';
import 'package:shomineh/src/data/models/base/data_pool.dart';
import 'package:shomineh/src/ui/widgets/KeyboardVisibility.dart';
import 'package:shomineh/src/ui/widgets/LoadingView.dart';
import 'package:shomineh/src/ui/widgets/Space.dart';

import '../../../config/constants/Constants.dart';

/// [BaseScaffold] is base widget with certain properties.It can have [drawer], and [children]
/// Also its width is changeable.
class BaseScaffold extends StatelessWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final Widget child;
  final Widget? drawer;
  final Widget? header;
  final Widget? floatingActionButton;
  final double? width;
  final double? height;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final DataPool<bool>? showLoading;
  final bool showLoadingCondition;
  final bool showBottomNavigation;
  final bool resizeToAvoidBottomInset;
  final EdgeInsetsGeometry? padding;
  final PreferredSizeWidget? appBar;
  final Color? childBackgroundColor;
  final Function(bool)? onKeyboardVisibilityChange;
  final Function()? onBackPressed;

  const BaseScaffold(
      {super.key,
      required this.child,
      this.drawer,
      this.scaffoldKey,
      this.header,
      this.floatingActionButton,
      this.floatingActionButtonLocation,
      this.floatingActionButtonAnimator,
      this.height,
      this.showLoading,
      this.showLoadingCondition = true,
      this.showBottomNavigation = true,
      this.resizeToAvoidBottomInset = false,
      this.width,
      this.onKeyboardVisibilityChange,
      this.onBackPressed,
      this.padding,
      this.appBar,
      this.childBackgroundColor});

  void _onBack(bool pop, dynamic result) {
    if (pop) {
      // If back navigation was allowed, do nothing.
      return;
    }
    printMessage(
        "+*+*+*+*+* _onBack called onBackPressed.isNull:${onBackPressed.isNull}");
    onBackPressed?.call();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibility(
        builder: (context, child, isVisible) {
          onKeyboardVisibilityChange?.call(isVisible);
          return child;
        },
        child: PopScope(
          canPop: onBackPressed.isNull,
          //true closes screen( action will be handled by OS), false does nothing
          onPopInvokedWithResult: _onBack,
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: AppTheme.colors.background,
            floatingActionButton: floatingActionButton,
            floatingActionButtonLocation: floatingActionButtonLocation,
            floatingActionButtonAnimator: floatingActionButtonAnimator,
            appBar: appBar,
            resizeToAvoidBottomInset: resizeToAvoidBottomInset,
            drawer: drawer,
            body: Directionality(
              textDirection: TextDirection.rtl,
              child: SafeArea(
                  child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Align(alignment: Alignment.topCenter, child: _body()),
                  /*Visibility(
                        visible:
                            bottomNavigation.isNotNull && showBottomNavigation,
                        child: Positioned.fill(
                            child: Align(
                          alignment: Alignment.bottomCenter,
                          child: bottomNavigation,
                        )),
                      ),*/
                  ValueListenableBuilder(
                      valueListenable: showLoading ?? DataPool.init(false),
                      builder: (context, showLoading, _) {
                        return LoadingView(
                          isVisible: showLoading && showLoadingCondition,
                          topPadding: header.isNotNull ? headerHeight + 12 : 12,
                        );
                      })
                ],
              )),
            ),
          ),
        ));
  }

  Widget _body() {
    return OrientationBuilder(
      builder: (context, orientation) {

        return Column(
          children: [
            header ??
                const Space(
                  height: 0,
                ),
            Expanded(
              child: Container(
                /*height: ScreenSizeHelper.getHeight() -
                  (header.isNotNull ? headerHeight : 0),*/
                color: childBackgroundColor,
                padding: padding ??
                    const EdgeInsets.only(
                      right: 8,
                      left: 8,
                    ),
                child: child,
              ),
            ),
          ],
        );
      }
    );
  }
}
