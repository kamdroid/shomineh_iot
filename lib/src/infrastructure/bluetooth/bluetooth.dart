import 'dart:async';
import 'dart:convert';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:shomineh/common/Util.dart';
import 'package:shomineh/common/extensions.dart';
import 'package:shomineh/config/resources/Urls.dart';
import 'package:shomineh/di/DiHelper.dart';
import 'package:shomineh/src/data/models/base/Pair.dart';
import 'package:shomineh/src/infrastructure/store/StoreUnit.dart';

class Bluetooth {
  static Bluetooth get instance => DiHelper.bluetooth;

  final StoreUnit storeUnit;

  String _ordersBuffer = "";

  Bluetooth(this.storeUnit){
    FlutterBluePlus.setLogLevel(LogLevel.verbose);

    _ordersController = StreamController.broadcast();
  }

  StreamSubscription<BluetoothAdapterState>? _bluetoothSubscription;

  late StreamController<String> _ordersController;
  StreamController<String> get ordersStream => _ordersController;

  BluetoothCharacteristic? _bluetoothWriteCharacteristic, _bluetoothReadCharacteristic;

  void _handleEvents(void Function(bool?)? stateFunction) {
    if (_bluetoothSubscription.isNull) {
      _bluetoothSubscription = FlutterBluePlus.adapterState.listen((state) {
        printMessage("bluetooth state:$state");

        switch (state) {
          case BluetoothAdapterState.turningOn:
            break;
          case BluetoothAdapterState.on:
            stateFunction?.call(true);

            _bluetoothSubscription?.cancel();
            _bluetoothSubscription = null;
            break;

          case BluetoothAdapterState.unavailable:
          case BluetoothAdapterState.off:
          case BluetoothAdapterState.turningOff:
            stateFunction?.call(false);
            break;

          default:
            printMessage("turning on is not supported");
            stateFunction?.call(null);
        }
      });
    }
  }

  void turnOn({void Function(bool? turnedOn)? state}) async {
    _handleEvents(state);
    if (isTargetAndroidApp) {
      printMessage("start turning on");
      await FlutterBluePlus.turnOn();
    }
  }

  void turnOff() {
    _bluetoothSubscription?.cancel();
    _bluetoothSubscription = null;
    _bluetoothWriteCharacteristic = null;
  }

  Future<bool> checkBluetoothIsSupported() async {
    return await FlutterBluePlus.isSupported == true;
  }

  Future<bool> scanForDevices(
      {void Function(List<ScanResult>)? devices}) async {
    var subscription = FlutterBluePlus.onScanResults.listen(
      (results) {
        if(results.isNotEmpty) {
          devices?.call(results
            .where((item) => item.device.platformName.toLowerCase().contains("shomine"))
            // .where((item) => item.device.platformName.isNotEmpty)
            .toSet()
            .toList());
        }
      },
      onError: (e) {},
    );
    FlutterBluePlus.cancelWhenScanComplete(subscription);

    await FlutterBluePlus.startScan(
        // withServices:[Guid("180D")],
        // withNames:["Shomine"],
        timeout: const Duration(seconds: 20));

    return await FlutterBluePlus.isScanning.where((val) => val == false).first;
  }

  void stopScan() async {
    if (isTargetPhone) {
      await FlutterBluePlus.stopScan();
    }
  }

  Future<bool> connect(BluetoothDevice scannedDevice) async {
    try{
      await scannedDevice.connect();
    } catch (e){
      return false;
    }
    _saveDevice(scannedDevice);
    final characteristics = await _discoverServices(scannedDevice);
    _bluetoothWriteCharacteristic = characteristics.second;
    _bluetoothReadCharacteristic = characteristics.first;

    return _bluetoothWriteCharacteristic.isNotNull && _bluetoothReadCharacteristic.isNotNull;
  }

  void _saveDevice(BluetoothDevice device) {
    if (device.remoteId.str != storeUnit.getBluetoothId()) {
      storeUnit.setBluetoothId(device.remoteId.str);
    }
  }

  BluetoothDevice? getPairedBluetooth() {
    if (storeUnit.getBluetoothId().isEmpty) {
      return null;
    }

    return BluetoothDevice.fromId(storeUnit.getBluetoothId());
  }

  Future<Pair<BluetoothCharacteristic?, BluetoothCharacteristic?>> _discoverServices(BluetoothDevice bluetoothDevice) async {

    final services = await bluetoothDevice.discoverServices();
    if(services.isNotEmpty) {

      BluetoothService? service = services
          .where((service) => service.serviceUuid.toString() == Credential.serviceUuid)
          .first;
      if (service.isNotNull) {
        BluetoothCharacteristic? read = service.characteristics.where((character) => character.properties.read == true).first;
        BluetoothCharacteristic? write = service.characteristics.where((character) => character.properties.write == true).first;

        return Pair(read, write);
      }
    }
    return Pair(null, null);
  }

  void sendData(String data, {void Function(String)? onDone, void Function(String)? onError}) async {
    if (_bluetoothWriteCharacteristic.isNotNull) {
      try {
        printMessage("sending data:$data");
        await _bluetoothWriteCharacteristic?.write(utf8.encode(data));
        printMessage("data has sent:$data");
        onDone?.call(data);
      } on Exception catch (e) {
        onError?.call(e.toString());
      }
    } else {
      onError?.call("Bluetooth device is not selected");
    }
  }

  void readData(
      {void Function(String)? response, void Function(String)? onError}) async {

    try {
      if (_bluetoothReadCharacteristic.isNotNull &&
          (_bluetoothReadCharacteristic?.properties.read == true)) {
        final data = await _bluetoothReadCharacteristic?.read();

        if (data.isNotNull) {
          _sendDataStream(utf8.decode(data!));
        }
      } else {
        onError?.call(
            'Characteristic does not support notifications or indications.');
      }
    } catch (e) {
      onError?.call('Error starting notifications: $e');
    }

  }
  void startMessaging(
      {void Function(String)? onError}) async {
    try {
      if (_bluetoothReadCharacteristic.isNotNull &&
          (_bluetoothReadCharacteristic?.properties.notify == true ||
              _bluetoothReadCharacteristic?.properties.read == true)) {
        await _bluetoothReadCharacteristic?.setNotifyValue(true);

        _bluetoothReadCharacteristic?.lastValueStream.listen((List<int> value) {
          if (value.isNotEmpty) {
            _sendDataStream(utf8.decode(value));
          }
        });
      } else if (_bluetoothReadCharacteristic?.properties.indicate == true) {
        await _bluetoothReadCharacteristic?.setNotifyValue(true);
        _bluetoothReadCharacteristic?.lastValueStream.listen((List<int> value) {
          if (value.isNotEmpty) {
            _sendDataStream(utf8.decode(value));
          }
        });
      } else {
        onError?.call(
            'Characteristic does not support notifications or indications.');
      }
    } catch (e) {
      onError?.call('Error starting notifications: $e');
    }
  }

  List<BluetoothDevice> getConnectedDevices(){
    return FlutterBluePlus.connectedDevices;
  }

  void _sendDataStream(String order){

    int pos = order.lastIndexOf("\n");

    if(pos > -1) {
      _ordersController.sink.add(_ordersBuffer + order.substring(0, pos));
      _ordersBuffer = order.substring(pos);
    } else {
      _ordersBuffer += order;
    }

  }

}
