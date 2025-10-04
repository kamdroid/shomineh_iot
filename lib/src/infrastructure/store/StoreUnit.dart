import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shomineh/di/DiHelper.dart';


class StoreUnit {

  static StoreUnit get instance => DiHelper.storeUnit;
  SharedPreferences sharedPreferences;

  StoreUnit(this.sharedPreferences);

  String _THEME = "Theme";
  final String _bluetoothDeviceId = "bluetoothDeviceId";


  String getBluetoothId() => _getItem(_bluetoothDeviceId, "");
  Future<String> setBluetoothId(String value) => _setItem(_bluetoothDeviceId, value);

  String getTheme() => _getItem(_THEME, "");
  Future<String> setTheme(String value) => _setItem(_THEME, value);


  void clearAll(){
    clearCredentials();
  }
  void clearCredentials() {
    setBluetoothId("");
  }



  /// generic method for [restoring] values.
  /// attention: long is not supported.
  T _getItem<T>(String key, T def_value) {
    // var completer = Completer<T>();

    T val;
    switch (T) {
      case int:
        val = (sharedPreferences.getInt(key) ?? ((def_value) as int)) as T;
        // completer.complete(val as T);
        break;
      case String:
        val = (sharedPreferences.getString(key) ?? ((def_value) as String)) as T;
        // completer.complete(val as T);
        break;
      case double:
        val = (sharedPreferences.getDouble(key) ?? ((def_value) as double)) as T;
        // completer.complete(val as T);
        break;
      case bool:
        val = (sharedPreferences.getBool(key) ?? ((def_value) as bool)) as T;
        // completer.complete(val as T);
        break;
      default:
        throw StateError("this type is not supported");
    }

    return val;
  }

  /// generic method for [storing] values.
  /// it returns future value of first value.
  Future<T> _setItem<T>(String key, T value) async {
    Future<T> val;
    switch (T) {
      case int:
        val = sharedPreferences.setInt(key, value as int).then((success) => value);
        break;
      case String:
        val =
            sharedPreferences.setString(key, value as String).then((success) => value);
        break;
      case double:
        val =
            sharedPreferences.setDouble(key, value as double).then((success) => value);
        break;
      case bool:
        val = sharedPreferences.setBool(key, value as bool).then((success) => value);
        break;
      default:
        throw StateError("this type is not supported");
    }

    return val;
  }

}
