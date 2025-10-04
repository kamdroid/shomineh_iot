import 'dart:async';

abstract class IBluetoothCommunicationDatasource {
  void sendData(String data, {void Function(String)? onDone, void Function(String)? onError});

  void startMessaging(
      {void Function(String)? onError});

  void readData(
      {required void Function(String) response, void Function(String)? onError});

  StreamController<String> orderStream();

}
