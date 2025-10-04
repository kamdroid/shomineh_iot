

import 'package:flutter/material.dart';
import 'package:shomineh/common/Util.dart';
import 'package:shomineh/config/base/baseUiState.dart';
import 'package:shomineh/src/data/enums/SnackTypes.dart';
import 'package:shomineh/src/ui/widgets/CommonUi.dart';

abstract class BaseNotifier<T extends BaseUiState> with ChangeNotifier{

  T uiState;
  late BuildContext context;

  BaseNotifier(this.uiState);

  void showLoading() {
    uiState.startLoading();
    printMessage("-*-*-*-*-*-* showLoading");

    // updateScreen();
  }

  void justShowLoading() {
    uiState.startLoading();
  }

  void stopLoading() {
    uiState.stopLoading();
    printMessage("-*-*-*-*-*-* stopLoading");

    // updateScreen();
  }

  void justStopLoading() {
    uiState.stopLoading();
  }
  void showError(String error) {
    showMessageModal(error,
        type: SnackTypes.error, duration: const Duration(days: 1));
  }

  void showErrorModal(
      String error, {
        String? label,
        Function()? onPressed,
      }) {
    showMessageModal(error,
        type: SnackTypes.error, label: label, onPressed: onPressed);
  }

  void showErrorModalInfinity(
      String error, {
        String label = '',
        double bottomSpace = 10,
        bool usePersianFont = true,
        Function()? onPressed,
      }) {
    showMessageModal(error,
        type: SnackTypes.error,
        label: label,
        bottomSpace: bottomSpace,
        usePersianFont: usePersianFont,
        duration: const Duration(days: 1),
        onPressed: onPressed);
  }

  void showMessageModal(String message,
      {Function()? onPressed,
        required SnackTypes type,
        bool usePersianFont = true,
        double bottomSpace = 10,
        String? label,
        Duration duration = const Duration(seconds: 5)}) {
    if (message.isNotEmpty) {
      Snack.instance.showSnackCustomModalView(message,
          context: context,
          onPressed: onPressed,
          label: label,
          type: type,
          bottomSpace: bottomSpace,
          duration: duration,
          usePersianFont: usePersianFont);
    }
  }

  void hideSnack() {
    Snack.instance.hideModal();
  }


}