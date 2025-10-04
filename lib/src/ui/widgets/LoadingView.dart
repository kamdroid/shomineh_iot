import 'package:flutter/material.dart';
import 'package:shomineh/src/ui/widgets/LoadAnimation.dart';

class LoadingView extends StatelessWidget {
  final bool isVisible;
  final double topPadding;

  LoadingView({Key? key, this.isVisible = false, this.topPadding = 12}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(top: topPadding),
        child: const LoadAnimation(
          height: 16,
        ),
      ),
    );
  }
}
