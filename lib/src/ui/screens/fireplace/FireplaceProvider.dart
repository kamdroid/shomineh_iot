import 'package:flutter/material.dart';
import 'package:shomineh/common/Util.dart';
import 'package:shomineh/common/extensions.dart';
import 'package:shomineh/config/constants/Constants.dart';
import 'package:shomineh/config/theme/AppTheme.dart';
import 'package:shomineh/src/data/enums/HeaterStatus.dart';
import 'package:shomineh/src/data/mappers/StringMapper.dart';
import 'package:shomineh/src/domain/repositories/bluetooth_communication_repository.dart';
import 'package:shomineh/src/ui/base/BaseProviderForStateless.dart';
import 'package:shomineh/src/ui/dialogs/Dialogs.dart';
import 'package:shomineh/src/ui/screens/fireplace/FirePlaceState.dart';
import 'package:shomineh/src/ui/screens/fireplace/dialogs/ColorPickerDialogs.dart';
import 'package:shomineh/src/ui/screens/fireplace/dialogs/FireplaceDialogs.dart';

class FireplaceProvider extends BaseProviderForStateless<FirePlaceState> {
  final BluetoothCommunicationRepository communicationRepository;

  int _rColor = -1;
  int _gColor = -1;
  int _bColor = -1;

  FireplaceProvider(this.communicationRepository)
      : super(FirePlaceState.init());

  bool get pageEnable {
    return !isLoading && uiState.switchValue.value;
  }

  String get fireVolume =>
      uiState.speaker.value >= 0 ? uiState.speaker.value.toString() : "";

  String get fireLight =>
      uiState.light.value >= 0 ? uiState.light.value.toString() : "";

  List<Color> get fireColorList => [
        AppTheme.colors.black,
        AppTheme.colors.blue,
        AppTheme.colors.teal,
        AppTheme.colors.purple,
        AppTheme.colors.green,
        AppTheme.colors.yellowGold,
        AppTheme.colors.orange,
        AppTheme.colors.redLight,
        AppTheme.colors.colorPallet8,
        AppTheme.colors.colorPallet7,
        AppTheme.colors.colorPallet6,
        AppTheme.colors.colorPallet5,
        AppTheme.colors.colorPallet4,
        AppTheme.colors.colorPallet3,
        AppTheme.colors.colorPallet2,
        AppTheme.colors.colorPallet1,
      ];

  @override
  void initializer() {
    super.initializer();

    communicationRepository.orderStream().stream.listen((message){

      printMessage("response in listener stream: $message");
      onReceiveData(stringToHashMap(message));
    });

    communicationRepository.startMessaging(onError: (error) {
      printMessage("error in listener: $error");
    });

    sendData("Hi");
  }

  Color? get fireColor {
    switch (uiState.fireColorIndex.value) {
      case -1:
      case -100:
        return null;
      case -2:
        return uiState.selectedColor.value;

      default:
        return fireColorList[uiState.fireColorIndex.value];
    }
  }

  void sendData(String data, {void Function(String)? onError}) {
    showLoading();
    communicationRepository.publishMessage(data, onDone: (sentData) {
      stopLoading();
    }, onError: (error) {
      onError?.call(error);
      stopLoading();
    });
  }

  void onFirePlaceChanged(bool val) {
    if (uiState.switchValue.value != val) {
      uiState.switchValue.value = val;

      sendData(uiState.switchValue.value ? "P1" : "P0", onError: (error) {
        uiState.switchValue.value = !uiState.switchValue.value;
      });
    }
  }

  void onFirePlaceHeatChanged(double val) {
    if (uiState.fireplaceValue.value != val) {
      final prev = uiState.fireplaceValue.value;
      uiState.fireplaceValue.value = val;

      sendData("TSP${val.toInt().toString().padLeft(2, '0')}",
          onError: (error) {
        uiState.fireplaceValue.value = prev;
      });
    }
  }

  void onPlayMobileSoundStateChanged(bool val) {
    if (uiState.playMobileSwitchValue.value != val) {
      uiState.playMobileSwitchValue.value = val;

      sendData(val ? 'MS1' : 'MS0', onError: (error) {
        uiState.playMobileSwitchValue.value =
            !uiState.playMobileSwitchValue.value;
      });
    }
  }

  void onFirePlaceActivationChanged() {
    uiState.fireplaceEnable.value = !uiState.fireplaceEnable.value;
    // _colorIndexCorrection();

    sendData(uiState.fireplaceEnable.value ? "A1" : "A0", onError: (error) {
      uiState.fireplaceEnable.value = !uiState.fireplaceEnable.value;
    });
  }

  void _colorIndexCorrection() {
    if (!uiState.fireplaceEnable.value) {
      uiState.fireColorIndex.value = -100;
    } else {
      uiState.fireColorIndex.value = -1;
    }
  }

  void onFirePlaceColorSelected(int index) {
    printMessage(
        "onFirePlaceColorSelected index:$index  uiState.fireColorIndex:${uiState.fireColorIndex}");
    if (uiState.fireColorIndex.value != index) {
      final prev = uiState.fireColorIndex.value;
      uiState.fireColorIndex.value = index;
      if (index >= 0) {
        final prevColor = uiState.selectedColor.value;
        uiState.selectedColor.value = fireColorList[index];

        sendData("CC${(index + 1).toString().padLeft(2, '0')}",
            onError: (error) {
          uiState.fireColorIndex.value = prev;
          uiState.selectedColor.value = prevColor;
          printMessage(
              "uiState.fireColorIndex:${uiState.fireColorIndex.value} prev:$prev");
        });
      }
    }
  }

  Future<void> setFireVolume() async {
    int? vol = await Dialogs.instance.showBottomSheet(
        child: FireSound(
      initValue: uiState.speaker.value,
    ));

    if (vol.isNotNull) {
      if (uiState.speaker.value != vol) {
        final prev = uiState.speaker.value;
        uiState.speaker.value = vol!;

        sendData("FS${vol.toString().padLeft(3, '0')}", onError: (error) {
          uiState.speaker.value = prev;
        });
      }
    }
  }

  Future<void> setFireLight() async {
    int? light = await Dialogs.instance.showBottomSheet(
        child: FireLight(
      initValue: uiState.light.value,
    ));

    if (light.isNotNull && uiState.light.value != light) {
      final prev = uiState.light.value;
      uiState.light.value = light!;

      sendData("FB$light", onError: (error) {
        uiState.light.value = prev;
      });
    }
  }

  Future<void> selectColor() async {
    Color? color = await Dialogs.instance.createTransparentDialog(
        child: ColorPickerDialogs(
      initColor: uiState.selectedColor.value,
    ));
    if (color.isNotNull && color != uiState.selectedColor.value) {
      final prev = uiState.selectedColor.value;
      uiState.selectedColor.value = color!;
      onFirePlaceColorSelected(-2);

      int r = (color.r * 255).round();
      int g = (color.g * 255).round();
      int b = (color.b * 255).round();

      sendData(
          "R${r.toString().padLeft(3, '0')}G${g.toString().padLeft(3, '0')}B${b.toString().padLeft(3, '0')}",
          onError: (error) {
        uiState.selectedColor.value = prev;
      });
    }
  }

  void setHeaterLow() {
    if (pageEnable) {
      if (!uiState.heaterStatus.value.isLow) {
        _publishHeaterOff(HeaterStatus.low);
      } else {
        _setHeaterOff();
      }
    }
  }

  void setHeaterHigh() {
    if (pageEnable) {
      if (!uiState.heaterStatus.value.isHigh) {
        _publishHeaterOff(HeaterStatus.high);
      } else {
        _setHeaterOff();
      }
    }
  }

  void setHeaterAuto() {
    if (pageEnable) {
      if (!uiState.heaterStatus.value.isAuto) {
        _publishHeaterOff(HeaterStatus.auto);
      } else {
        _setHeaterOff();
      }
    }
  }

  void _setHeaterOff() {
    _publishHeaterOff(HeaterStatus.off);
  }

  void _publishHeaterOff(HeaterStatus status) {
    if (status != uiState.heaterStatus.value) {
      final prev = uiState.heaterStatus.value;
      uiState.heaterStatus.value = status;

      sendData("H${status.id}", onError: (error) {
        uiState.heaterStatus.value = prev;
      });
    }
  }

  void onReceiveData(Map<String, String> data) {
    printMessage("*/*/*/*/* onReceiveData Fireplace data:$data");
    if (data['P'].isNotNull) {
      uiState.switchValue.value = data['P']!.toBoolean;
    }

    if (data['MS'].isNotNull) {
      uiState.playMobileSwitchValue.value = data['MS']!.toBoolean;
    }
    if (data['H'].isNotNull) {
      uiState.heaterStatus.value = HeaterStatusUtil.getState(data['H']!.toInt);
    }

    if (data['TPV'].isNotNull) {
      uiState.temperature.value = data['TPV']!.toDouble;
    }

    if (data['TSP'].isNotNull) {
      if (data['TSP']!.toDouble > maxTemp) {
        uiState.fireplaceValue.value = maxTemp;
      } else if (data['TSP']!.toDouble < minTemp) {
        uiState.fireplaceValue.value = minTemp;
      } else {
        uiState.fireplaceValue.value = data['TSP']!.toDouble;
      }
    }

    if (data['R'].isNotNull) {
      _rColor = data['R']!.substring(0, 3).toInt;
    }
    if (data['G'].isNotNull) {
      _gColor = data['G']!.substring(0, 3).toInt;
    }
    if (data['B'].isNotNull) {
      _bColor = data['B']!.substring(0, 3).toInt;
    }

    if (_rColor > -1 &&
        _gColor > -1 &&
        _bColor > -1 &&
        uiState.fireColorIndex.value <= 0) {
      uiState.selectedColor.value = Color.fromRGBO(_rColor, _gColor, _bColor, 1);
      uiState.fireColorIndex.value = -2;
      _rColor = -1;
      _gColor = -1;
      _bColor = -1;
    }

    if (data['CC'].isNotNull) {
      uiState.fireColorIndex.value =
          (data['CC']!.toInt <= 16 && data['CC']!.toInt >= 1)
              ? (data['CC']!.toInt - 1)
              : -2;
    }

    if (data['A'].isNotNull) {
      uiState.fireplaceEnable.value = data['A']!.toBoolean;
    }

    if (data['FS'].isNotNull) {
      if (data['FS']!.toInt > 100) {
        uiState.speaker.value = 100;
      } else if (data['FS']!.toInt < 0) {
        uiState.speaker.value = 0;
      } else {
        uiState.speaker.value = data['FS']!.toInt;
      }
    }

    if (data['FB'].isNotNull) {
      if (data['FB']!.toInt > 5) {
        uiState.light.value = 5;
      } else if (data['FB']!.toInt < 0) {
        uiState.light.value = 0;
      } else {
        uiState.light.value = data['FB']!.toInt;
      }
    }

    stopLoading();
  }
}
