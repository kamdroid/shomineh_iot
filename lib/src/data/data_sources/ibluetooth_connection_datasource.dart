

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

abstract class IBluetoothConnectionDatasource{

  void turnOn({void Function(bool? turnedOn)? state});
  void turnOff();
  Future<bool> isBluetoothSupported();
  Future<bool> scanForDevices({void Function(List<ScanResult>)? devices});
  void stopScan();
  Future<bool> connect(BluetoothDevice scannedDevice);
  BluetoothDevice? getPairedBluetooth();
  List<BluetoothDevice> getConnectedDevices();

}