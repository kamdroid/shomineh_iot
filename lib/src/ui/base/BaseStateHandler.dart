import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shomineh/config/base/baseUiState.dart';
import 'package:shomineh/src/ui/base/BaseProvider.dart';

abstract class BaseStateHandler<T extends StatefulWidget, B extends BaseProvider, S extends BaseUiState>
    extends State<T> {
  late B providerModel;

  Widget buildUi(BuildContext context, S uiState);

  void updateScreen() {
    providerModel.updateScreen();
  }

  void _initBloc() {
    providerModel = Provider.of(context);

    providerModel.initBloc();

    if (!providerModel.initializerLock) {
      providerModel.initializer();
      providerModel.context = context;

      if(this is TickerProvider) {
        providerModel.initTickerState(this as TickerProvider);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _initBloc();

    return Consumer<B>(
      builder: (BuildContext context, value, Widget? child) => buildUi(context, providerModel.uiState as S),
    );
  }

  @override
  void dispose() {
    providerModel.clearAll();
    super.dispose();
  }
}
