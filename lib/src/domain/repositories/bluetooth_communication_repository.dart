import 'dart:async';

import 'package:shomineh/src/data/data_sources/ibluetooth_communication_datasource.dart';

class BluetoothCommunicationRepository {
  final IBluetoothCommunicationDatasource communicationDatasource;

  BluetoothCommunicationRepository(this.communicationDatasource);

  void publishMessage(String code, {void Function(String)? onDone, void Function(String)? onError}) {
    communicationDatasource.sendData(code, onDone: onDone, onError: onError);
  }

  void startMessaging(
      {void Function(String)? onError}) {
    communicationDatasource.startMessaging(onError: onError);
  }

  void readData(
      {required void Function(String) response,
      void Function(String)? onError}) {
    communicationDatasource.readData(response: response, onError: onError);
  }

  StreamController<String> orderStream(){
    return communicationDatasource.orderStream();
  }

}
