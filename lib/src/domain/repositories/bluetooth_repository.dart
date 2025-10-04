


import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:shomineh/src/data/data_sources/ibluetooth_connection_datasource.dart';

class BluetoothRepository{

  final IBluetoothConnectionDatasource connectionDatasource;

  BluetoothRepository(this.connectionDatasource);


  Future<bool> bluetoothIsSupported() => connectionDatasource.isBluetoothSupported();

  void turnOn(void Function(bool?) state){
    connectionDatasource.turnOn(state: state);
  }

  Future<bool> searchForDevices({required void Function(List<ScanResult>) foundedDevices}){
    return connectionDatasource.scanForDevices(devices: foundedDevices);
  }

  Future<bool> connect(BluetoothDevice device){
    return connectionDatasource.connect(device);
  }

  List<BluetoothDevice> getConnectedDevices(){
    return connectionDatasource.getConnectedDevices();
  }

}