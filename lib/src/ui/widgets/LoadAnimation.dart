import 'package:flutter/material.dart';
import 'package:shomineh/config/theme/AppTheme.dart';
import 'package:shomineh/src/data/models/base/Pair.dart';

class LoadAnimation extends StatefulWidget {
  final int numberOfBullets;
  final BoxDecoration? decoration;
  final double? width, height;
  final double bulletSize;
  final double bulletDistance;
  final Color? sideColor, middleColor;

  const LoadAnimation({
    super.key,
    this.numberOfBullets = 3,
    this.bulletDistance = 3,
    this.bulletSize = 6,
    this.decoration,
    this.width,
    this.sideColor,
    this.middleColor,
    this.height,
  });

  @override
  State<StatefulWidget> createState() => _LoadAnimation();
}

class _LoadAnimation extends State<LoadAnimation>
    with TickerProviderStateMixin {
  late List<Pair<AnimationController?, Animation<Offset>>> _controllers;

  late int _stepper;

  @override
  void initState() {
    super.initState();

    _stepper = 1;
    _controllers = List.empty(growable: true);

    for (int index = 0; index < widget.numberOfBullets; index++) {
      final control = AnimationController(
        duration: const Duration(milliseconds: 150),
        vsync: this,
      )..addStatusListener((status) {

          Future.delayed(const Duration(milliseconds: 1)).then((onValue) {
            if (status.isCompleted) {
              _controllers[index].first?.reverse();
            } else if (status.isDismissed) {
              final next = _nextIndex(index);
              _controllers[next].first?.forward();
            }
          });
        });

      final offset = Tween<Offset>(
        begin: Offset.zero,
        end: const Offset(0, -0.75),
      ).animate(CurvedAnimation(
        parent: control,
        curve: Curves.easeInOut,
      ));

      _controllers.add(Pair(control, offset));
    }

    _controllers.first.first?.forward();
  }

  int _nextIndex(int index) {
    int next = index + _stepper;

    if (next >= widget.numberOfBullets) {
      _stepper = -1;
    } else if (next < 0) {
      _stepper = 1;
    }
    return index + _stepper;
  }

  @override
  void dispose() {
    for (var item in _controllers) {
      item.first?.dispose();
      item.first = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: widget.decoration,
      // color: widget.loadingBackgroundColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: _controllers
            .asMap()
            .map((index, item) => MapEntry(
                index,
                SlideTransition(
                  position: item.second,
                  child: Container(
                    width: widget.bulletSize,
                    height: widget.bulletSize,
                    margin: EdgeInsets.only(right: widget.bulletDistance/2, left: widget.bulletDistance/2),
                    decoration: AppTheme.containerBorder(
                        color: (index % 2 == 0)
                            ? (widget.sideColor ?? AppTheme.colors.primaryColor)
                            : (widget.middleColor ?? AppTheme.colors.secondaryColor),
                        cornerCurve: 20,
                        borderWidth: 0),
                  ),
                )))
            .values
            .toList(),
      ),
    );
  }
}
