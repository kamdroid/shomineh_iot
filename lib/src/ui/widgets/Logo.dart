
import 'package:flutter/material.dart';
import 'package:shomineh/config/resources/Images.dart';
import 'package:shomineh/src/ui/widgets/Space.dart';

class Logo extends StatelessWidget {
  final double? height;
  final double? width;
  final double space;


  const Logo({super.key, this.height, this.width, this.space = 8});

  @override
  Widget build(BuildContext context) => SizedBox(
        height: height,
        width: width,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Center(child: Images.instance.getSizedImageSvg('logo',width: width)),
        Space(height: space,),
        Center(child: Images.instance.getImageSvg('bawan')),
      ],
    ),
      );
}
