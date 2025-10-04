


import 'package:shomineh/src/data/models/base/data_pool.dart';

abstract class BaseUiState{
  late DataPool<bool> _loading;

  BaseUiState({bool loading = false}){
    _loading = DataPool.init(loading);
    reset();
  }

  void reset(){}

  bool get isLoading => _loading.value;

  DataPool<bool> get loadingPool => _loading;

  void startLoading(){
    _loading.value = true;
  }

  void stopLoading(){
    _loading.value = false;
  }

}