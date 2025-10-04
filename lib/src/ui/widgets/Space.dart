import 'package:flutter/material.dart';

class Space extends StatelessWidget {
  final double height;
  final double width;


  const Space({super.key, this.height = 8, this.width = 4});

  @override
  Widget build(BuildContext context) => SizedBox(
        height: height,
        width: width,
      );
}
