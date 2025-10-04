import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shomineh/config/base/baseUiState.dart';
import 'package:shomineh/src/ui/base/BaseProviderForStateless.dart';

abstract class BaseStateless<P extends BaseProviderForStateless, S extends BaseUiState> extends StatelessWidget {
  late P providerModel;

  BaseStateless({super.key});

  // P setProvider();

  Widget buildUi(BuildContext context, S uiState);

  void updateScreen() {
    providerModel.updateScreen();
  }

  void _initBloc(BuildContext context) {
    providerModel = Provider.of(context);

    providerModel.initBloc();
    providerModel.context = context;

    if(!providerModel.initializerLock) {
      providerModel.initializer();
    }
  }


  @override
  Widget build(BuildContext context) {
    _initBloc(context);

    return Consumer<P>(
        builder: (BuildContext context, value, Widget? child) =>
            buildUi(context, providerModel.uiState as S));
  }

/*@override
  void dispose() {
    blocModel.clearStream();
    blocModel.clearAll();
    super.dispose();
  }*/
}
