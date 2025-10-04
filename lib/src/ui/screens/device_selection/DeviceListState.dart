
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:shomineh/config/base/baseUiState.dart';
import 'package:shomineh/src/data/models/base/data_pool.dart';

class DeviceListState extends BaseUiState {

  late ListDataPool<ScanResult> devices;
  late DataPool<bool> showTurnOnBluetooth;

  DeviceListState.init({super.loading = false});

  @override
  void reset() {

    devices = ListDataPool.empty();
    showTurnOnBluetooth = DataPool.init(false);

  }

  void setList(List<ScanResult> list){
    devices.value = list;
  }

  void clearList(){
    devices.value.clear();
  }

  void showBtButton(bool show){
    showTurnOnBluetooth.value = show;
  }

}

