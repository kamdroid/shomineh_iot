import 'package:flutter/material.dart';
import 'package:shomineh/config/theme/AppTheme.dart';

class MultiColorText extends StatelessWidget {
  final List<String> texts;
  final List<TextStyle> textStyle;
  final EdgeInsetsGeometry padding;
  final Decoration? decoration;
  final MainAxisAlignment mainAxisAlignment;
  final AlignmentGeometry alignment;

  const MultiColorText({
    super.key,
    required this.texts,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.textStyle = const [],
    this.decoration,
    this.alignment = Alignment.center,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    List<TextSpan> items = List.empty(growable: true);

    for (int pos = 0; pos < texts.length; pos++) {

      final st = (pos < textStyle.length) ? textStyle[pos] : AppTheme.fonts.faRegularMd(color: AppTheme.colors.black);

      items.add(TextSpan(
        text: texts[pos],
        style: st,
      ));
    }

    return Align(
      alignment: alignment,
      child: RichText(
        text: TextSpan(style: textStyle.first, children: items),
      ),
    );
  }
}
