
import 'package:flutter/material.dart';
import 'package:shomineh/common/Util.dart';
import 'package:shomineh/common/extensions.dart';
import 'package:shomineh/config/resources/Images.dart';
import 'package:shomineh/config/theme/AppTheme.dart';
import 'package:shomineh/src/ui/widgets/CustomPaddle.dart';
import 'package:shomineh/src/ui/widgets/Space.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class CustomSlider extends StatefulWidget {
  final double? width;
  double value;
  final ValueChanged<double>? onChanged;
  final String? label;
  final double min;
  final double max;
  final Decoration? decoration;
  final String? imageRight;
  final String? imageLeft;
  final bool visibleHandler;
  final bool isEnable;

  CustomSlider(
      {super.key,
      this.width,
      required this.value,
      this.decoration,
      this.onChanged,
      this.imageLeft,
      this.imageRight,
      this.visibleHandler = true,
      this.isEnable = true,
      this.label,
      this.min = 0,
      this.max = 100});

  @override
  State<StatefulWidget> createState() => _CustomSlider();
}

class _CustomSlider extends State<CustomSlider> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final hideAll = widget.imageLeft.isNull && widget.imageRight.isNull;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: SizedBox(
        height: hideAll ? 50 : 84,
        child: Column(
          children: [
            Visibility(
              visible: !hideAll,
              child: Padding(
                padding: const EdgeInsets.only(right: 24, left: 24),
                child: Row(
                  children: [
                    SizedBox(
                        width: 24,
                        height: 24,
                        child: Visibility(
                            visible: widget.imageLeft.isNotNull,
                            child: Images.instance.getImage(widget.imageLeft ?? ''))),
                    const Spacer(),
                    SizedBox(
                        width: 24,
                        height: 24,
                        child: Visibility(
                            visible: widget.imageRight.isNotNull,
                            child: Images.instance.getImage(widget.imageRight ?? ''))),
                  ],
                ),
              ),
            ),
            Space(
              height: hideAll ? 0 : 10,
            ),
            SizedBox(
              width: widget.width,
              height: 10,
              child: SfSliderTheme(
                data: const SfSliderThemeData(
                  activeTrackHeight: 20,
                  tooltipBackgroundColor: Colors.orange,
                ),
                child: Center(
                  child: SfSlider(
                    min: widget.min,
                    max: widget.max,
                    value: widget.value,
                    stepSize: 1,
                    interval: 20,
                    activeColor: Colors.orange,
                    inactiveColor: Colors.white,
                    enableTooltip: true,
                    showDividers: true,
                    onChangeEnd: (val) {
                      if (widget.isEnable) {
                        widget.value = val;
                        printMessage(
                            "*/*/*/*/*/ onHoodRotateStateChanged value:$val widget.value:${widget.value}");
                        widget.onChanged?.call(val);
                      }
                    },
                    onChanged: (dynamic value) {
                      if (widget.isEnable) {
                        widget.value = value;
                        setState(() {});
                      }
                    },
                  ),
                ),
              ),
            ),
            const Space(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 24, left: 24),
              child: Row(
                children: [
                  Text(
                    widget.min.toInt().toString(),
                    style: AppTheme.fonts.faRegularMd(),
                  ),
                  const Spacer(),
                  Text(
                    widget.max.toInt().toString(),
                    style: AppTheme.fonts.faRegularMd(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
