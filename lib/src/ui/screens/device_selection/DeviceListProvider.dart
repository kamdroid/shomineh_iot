import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shomineh/common/Util.dart';
import 'package:shomineh/common/extensions.dart';
import 'package:shomineh/config/resources/Strings.dart';
import 'package:shomineh/src/data/enums/SnackTypes.dart';
import 'package:shomineh/src/domain/repositories/bluetooth_repository.dart';
import 'package:shomineh/src/domain/repositories/location_repository.dart';
import 'package:shomineh/src/ui/base/BaseProviderForStateless.dart';
import 'package:shomineh/src/ui/dialogs/Dialogs.dart';
import 'package:shomineh/src/ui/screens/device_selection/DeviceListState.dart';
import 'package:shomineh/src/ui/screens/device_selection/dialogs/connect_to_bt_dialog.dart';
import 'package:shomineh/src/ui/screens/device_selection/dialogs/turn_on_bt_dialog.dart';
import 'package:shomineh/src/ui/screens/fireplace/FireplaceScreen.dart';

class DeviceListProvider extends BaseProviderForStateless<DeviceListState> {
  final BluetoothRepository bluetoothRepository;
  final LocationRepository locationRepository;

  DeviceListProvider(this.bluetoothRepository, this.locationRepository)
      : super(DeviceListState.init(loading: true));

  @override
  void initializer() {
    _supportBt();

    super.initializer();
  }

  Future<void> _checkPermission() async {
    if (isTargetPhone) {
      final btGranted = await Permission.bluetooth.request().isGranted;
      final locationGranted = await Permission.location.request().isGranted;

      if(/*!btGranted ||*/ !locationGranted){
        _showTurnBtButton();
      } else {
        _turnOnBluetooth();
      }

    } else {
      _turnOnBluetooth();
    }
  }

  void _showTurnBtButton(){
    stopLoading();
    uiState.showBtButton(true);
  }

  void _supportBt() {
    bluetoothRepository.bluetoothIsSupported().then((supported) {
      if (supported) {
        _checkPermission();
      } else {
        showErrorModalInfinity("not Supported");
      }
    }).onError((error, stack) {
      showErrorModalInfinity(error?.toString() ?? "---");
    });
  }

  void _turnOnBluetooth() {
    bluetoothRepository.turnOn((state) {
      if (state.isNull) {
        stopLoading();
        Dialogs.instance.createTransparentDialog(
            child: turnOnMessageDialog(onAction: _enableLocationService));
      } else if (state == true) {
        _enableLocationService();
      } else {
        showMessageModal(Strings.checkForTurningBTOn, type: SnackTypes.warning);
        _showTurnBtButton();
      }
    });
  }

  Future<void> _enableLocationService() async {
    if(!await locationRepository.isServiceEnabled()){
      await locationRepository.enableService();
    }

    printMessage("locationRepository.isServiceEnabled():${await locationRepository.isServiceEnabled()}");

    searchForDevices();
  }


  Future<void> searchForDevices() async {
    showLoading();
    uiState.showBtButton(false);
    await bluetoothRepository.searchForDevices(foundedDevices: (foundedDevices) {
      printMessage("number of founded devices:${foundedDevices.length}");
      // uiState.devices.value = foundedDevices;
      uiState.setList(foundedDevices);
      // uiState.devices.addValue = foundedDevices;
    });

    printMessage("searchForDevices finishes");
    stopLoading();
  }

  Future<void> refresh() async{
    if(!isLoading) {
      uiState.clearList();
      showLoading();
      uiState.showBtButton(false);
      _checkPermission();
    }
  }

  void onDeviceSelected(ScanResult result) {
    Dialogs.instance.createTransparentDialog(
        child: connectToDialog(device: result, onAction: () {

          bluetoothRepository.connect(result.device).then((connected){

            if(connected){
              FireplaceScreen.open();
            }


          });

        }));
  }
  
  bool isDeviceConnected(ScanResult device){

    if(bluetoothRepository.getConnectedDevices().isNotEmpty) {
      BluetoothDevice? founded = bluetoothRepository
          .getConnectedDevices()
          .where((item) => device.device.remoteId == item.remoteId)
          .first;

      return founded.isNotNull;
    }

    return false;
  }
}
