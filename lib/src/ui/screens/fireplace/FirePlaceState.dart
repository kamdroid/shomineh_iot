
import 'package:flutter/material.dart';
import 'package:shomineh/config/base/baseUiState.dart';
import 'package:shomineh/config/constants/Constants.dart';
import 'package:shomineh/src/data/enums/HeaterStatus.dart';
import 'package:shomineh/src/data/models/base/data_pool.dart';

class FirePlaceState extends BaseUiState {
  late DataPool<bool> switchValue, fireplaceEnable, playMobileSwitchValue;
  late DataPoolNullable<Color?> selectedColor;
  late DataPool<HeaterStatus> heaterStatus;
  late DataPool<double> temperature, fireplaceValue;
  late DataPool<int> light, speaker, fireColorIndex;

  FirePlaceState.init({super.loading = false});

  @override
  void reset() {
    selectedColor = DataPoolNullable.init(null);
    fireplaceValue = DataPool.init(minTemp);
    fireplaceEnable = DataPool.init(true);
    switchValue = DataPool.init(false);
    playMobileSwitchValue = DataPool.init(false);
    heaterStatus = DataPool.init(HeaterStatus.off);
    temperature = DataPool.init(0);
    speaker = DataPool.init(-1);
    light = DataPool.init(-1);
    fireColorIndex = DataPool.init(-1);
  }

}

