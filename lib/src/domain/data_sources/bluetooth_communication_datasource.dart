

import 'dart:async';

import 'package:shomineh/src/data/data_sources/ibluetooth_communication_datasource.dart';
import 'package:shomineh/src/infrastructure/bluetooth/bluetooth.dart';

class BluetoothCommunicationDatasource implements IBluetoothCommunicationDatasource{

  final Bluetooth bluetooth;
  BluetoothCommunicationDatasource(this.bluetooth);

  @override
  void sendData(String data, {void Function(String)? onDone, void Function(String)? onError}) {
    bluetooth.sendData(data,onDone: onDone, onError: onError);
  }

  @override
  void startMessaging({void Function(String p1)? onError}) {
    bluetooth.startMessaging(onError: onError);
  }


  @override
  void readData({required void Function(String p1) response, void Function(String p1)? onError}) {
    bluetooth.readData(response: response, onError: onError);
  }


  @override
  StreamController<String> orderStream(){
    return bluetooth.ordersStream;
  }

}