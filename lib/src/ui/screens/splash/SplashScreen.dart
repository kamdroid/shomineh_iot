
import 'package:flutter/material.dart';
import 'package:shomineh/config/theme/AppTheme.dart';
import 'package:shomineh/src/ui/base/BaseStateless.dart';
import 'package:shomineh/src/ui/screens/splash/SplashProvider.dart';
import 'package:shomineh/src/ui/screens/splash/SplashState.dart';
import 'package:shomineh/src/ui/widgets/BaseScaffold.dart';
import 'package:shomineh/src/ui/widgets/Logo.dart';
import 'package:shomineh/src/ui/widgets/Space.dart';

class SplashScreen extends BaseStateless<SplashProvider, SplashState> {
  SplashScreen({super.key});

  @override
  Widget buildUi(BuildContext context, uiState) {

    return BaseScaffold(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                const Logo(
                  width: 157,
                  height: 200,
                  space: 12,
                ),
                const Space(height: 12,),
                Text(
                    "خانه امن تو",
                    style: AppTheme.fonts.faRegularLg()
                )

              ]
          ),
        );
  }
}

