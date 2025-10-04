import 'package:flutter/material.dart';
import 'package:shomineh/src/ui/widgets/base/row_selectable.dart';

Widget fireplaceRowInfo(
        {required String imageNAme,
        required String title,
        String info = "",
        bool isEnable = true,
        Function()? onTap}) =>
    selectableRow(
        imageNAme: imageNAme,
        title: title,
        info: info,
        onTap: onTap,
        isEnable: isEnable);

Widget fireplaceRowSwitch({
  required String imageNAme,
  required String title,
  bool value = false,
  bool isEnable = true,
  ValueChanged<bool>? onChanged,
}) =>
    selectableRow(
        imageNAme: imageNAme,
        title: title,
        showSwitch: true,
        value: value,
        onChanged: onChanged,
        isEnable: isEnable);
