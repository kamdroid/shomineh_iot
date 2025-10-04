

import 'package:flutter/foundation.dart';
import 'package:shomineh/common/extensions.dart';
import 'package:shomineh/src/data/models/base/aspect.dart';

class DataPool<T> extends Aspect implements ValueListenable<T>{

  T _model;
  DataPool.init(this._model){
    assert(_model.isNotNull);
  }

  @override
  T get value => _model;

  set value(T model){
    _model = model;
    markDirty();
    notifyListeners();
  }

}
class DataPoolNullable<T> extends Aspect implements ValueListenable<T?>{

  T? _model;
  DataPoolNullable.init(this._model);

  @override
  T? get value => _model;

  set value(T? model){
    _model = model;
    markDirty();
    notifyListeners();
  }

}

class ListDataPool<T> extends Aspect implements ValueListenable<List<T>>{

  List<T> _list = List.empty(growable: true);


  ListDataPool.init(List<T> list){
    assert(_list.isNotNull);
    _list.clear();
    _list = List.unmodifiable(list);
  }

  ListDataPool.empty(){
    _list.clear();
  }

  @override
  List<T> get value => _list;

  set value(List<T> list){
    _list.clear();
    _list.addAll(list);
    notifyListeners();
  }

  set addValue(List<T> list){
    _list.addAll(list);
    notifyListeners();
  }

  void clear(){
    _list.clear();
  }

}