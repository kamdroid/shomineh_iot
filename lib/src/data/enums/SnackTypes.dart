

import 'package:flutter/material.dart';
import 'package:shomineh/config/theme/AppTheme.dart';

enum SnackTypes {
  success('check'),
  error('error'),
  warning('warning'),
  general('info');

  final String image;

  const SnackTypes(this.image);

  bool get isError => this == SnackTypes.error;
  bool get isSuccess => this == SnackTypes.success;


  Color get color {

    switch(this){
      case SnackTypes.success:
        return AppTheme.colors.Green;
      case SnackTypes.error:
        return AppTheme.colors.red;
      case SnackTypes.warning:
        return AppTheme.colors.orange;
      default:
        return AppTheme.colors.blue;
    }

  }

}