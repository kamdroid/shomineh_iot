
import 'package:flutter/material.dart';
import 'package:shomineh/common/Util.dart';
import 'package:shomineh/config/resources/Strings.dart';
import 'package:shomineh/config/theme/AppTheme.dart';
import 'package:shomineh/src/ui/widgets/Space.dart';

class CustomSwitch extends StatefulWidget {
  final bool value;
  final bool isEnable;
  final ValueChanged<bool>? onChanged;

  const CustomSwitch({Key? key, required this.value, this.onChanged, this.isEnable = true})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch>
    with SingleTickerProviderStateMixin {
  late Animation _circleAnimation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 120))
      /*..addListener(() {
        Util.printMessage("_circleAnimation.value:${_circleAnimation.value}");
      })*/;

    _circleAnimation = Tween(
            // begin: widget.value ? Alignment.centerRight : Alignment.centerLeft,
            // end: widget.value ? Alignment.centerLeft : Alignment.centerRight
            begin: 0,
            end: 45)
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.linear));

    printMessage("_circleAnimation.value:${_circleAnimation.value}");
  }

  @override
  Widget build(BuildContext context) {
    printMessage("-*/-*-*/-*/ widget.value:${widget.value}");
    if(widget.value){
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Row(
          children: [
            Container(
              constraints: const BoxConstraints(minWidth: 40),
              child: Text(
                _animationController.value == 0 ? Strings.off : Strings.on,
                style: AppTheme.fonts.faRegularXs(),
              ),
            ),

            const Space(width: 16,),
            GestureDetector(
              onTap: () {
                if(widget.isEnable) {
                  printMessage(
                      "isCompleted:${_animationController.isCompleted}");
                  printMessage(
                      "_circleAnimation.value:${_circleAnimation.value}");
                  if (_animationController.isCompleted) {
                    _animationController.reverse();
                    widget.onChanged?.call(false);
                  } else {
                    _animationController.forward();
                    widget.onChanged?.call(true);
                  }
                }
              },
              child: Container(
                width: 50.0,
                height: 28.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.0),
                  color: AppTheme.colors.black,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 2.0, bottom: 2.0, right: 4.0, left: 4.0),
                  child: Transform.translate(
                    offset: Offset(_animationController.value, 0),
                    child: Container(
                      alignment: _animationController.value == 0
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      child: Container(
                        width: 20.0,
                        height: 20.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (_animationController.value == 0)
                                ? AppTheme.colors.whiteColor
                                : AppTheme.colors.primaryColor),
                      ),
                    ),
                  ),
                ),
              ),
            ),

          ],
        );
      },
    );
  }
}
