import 'package:flutter/material.dart';
import 'package:shomineh/common/Util.dart';
import 'package:shomineh/config/base/baseUiState.dart';
import 'package:shomineh/navigation/Navigation.dart';
import 'package:shomineh/src/data/models/base/data_pool.dart';
import 'package:shomineh/src/ui/base/base_notifier.dart';
import 'package:shomineh/src/ui/widgets/CommonUi.dart';

abstract class BaseProvider<T extends BaseUiState> extends BaseNotifier<T> {

  BaseProvider(super.uiState);

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool get isLoading => uiState.isLoading;

  DataPool<bool> get loadingPool => uiState.loadingPool;

  bool? _initializerLock;


  bool get initializerLock => _initializerLock ?? false;



  void goBack<R>({R? result}) {
    printMessage("-*-*-*-*-*-* goBack pressed");
    // Navigation.instance.goOut();
    Navigation.instance.popFromStackNoContext(result: result);
  }

  void initBloc() {}

  void initializeAndResetValues() {}

  void initializer() {
    _initializerLock = true;
    initializeAndResetValues();
  }

  void initTickerState(TickerProvider vsync) {}

  void clearAll() {
    Snack.instance.hideModal();
    clearData();

  }

  void clearData() {
    justStopLoading();
    uiState.reset();

    Snack.instance.hideModal();

    initializeAndResetValues();
    _initializerLock = false;
  }

  void updateScreen({bool value = true}) {
    printMessage("updateScreen:$value");
    notifyListeners();
  }


}
