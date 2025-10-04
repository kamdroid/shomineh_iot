import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:shomineh/src/data/data_sources/ibluetooth_connection_datasource.dart';
import 'package:shomineh/src/infrastructure/bluetooth/bluetooth.dart';

class BluetoothConnectionDatasource implements IBluetoothConnectionDatasource {

  final Bluetooth bluetooth;
  BluetoothConnectionDatasource(this.bluetooth);

  @override
  Future<bool> connect(BluetoothDevice scannedDevice) {
    return bluetooth.connect(scannedDevice);
  }

  @override
  Future<bool> isBluetoothSupported() {
    return bluetooth.checkBluetoothIsSupported();
  }

  @override
  Future<bool> scanForDevices({void Function(List<ScanResult> result)? devices}) {
    return bluetooth.scanForDevices(devices: devices);
  }

  @override
  void stopScan() {
    bluetooth.stopScan();
  }

  @override
  void turnOn({void Function(bool? turnedOn)? state}) {
    bluetooth.turnOn(state: state);
  }

  @override
  void turnOff() {
    bluetooth.turnOff();
  }

  @override
  BluetoothDevice? getPairedBluetooth() {
    return bluetooth.getPairedBluetooth();
  }

  @override
  List<BluetoothDevice> getConnectedDevices() {
    return bluetooth.getConnectedDevices();
  }
}
