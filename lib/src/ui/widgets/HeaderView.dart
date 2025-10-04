
import 'package:flutter/material.dart';
import 'package:shomineh/common/extensions.dart';
import 'package:shomineh/common/screen_size_helper.dart';
import 'package:shomineh/config/constants/Constants.dart';
import 'package:shomineh/config/theme/AppTheme.dart';

class HeaderView extends StatelessWidget {
  final Widget title;
  final Widget? menu;
  final Function()? menuAction;
  final Widget? menuRight;
  final Function()? menuActionRight;

  const HeaderView({Key? key, required this.title,
    this.menu,
    this.menuAction,
    this.menuRight,
    this.menuActionRight,
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: headerHeight,
      width: ScreenSizeHelper.getWidthDeviceRelated(),
      child: Stack(
        children: [

          Align(
            alignment: Alignment.bottomCenter,
            child: title,
          ),

          Visibility(
            visible: menu.isNotNull,
            child: Positioned(
                left: 16,
                top: 12,
                child: GestureDetector(
              onTap: menuAction,
              child: menu,
            )),
          ),


          Positioned(
              right: 16,
              top: 12,
              child: Visibility(
                visible: menuActionRight.isNotNull,
                child: GestureDetector(
                  onTap: menuActionRight,
                  child: menuRight ?? Icon(Icons.delete_outline, color: AppTheme.colors.pink,),
                ),
              )),

        ],
      ),
    );
  }
}
