import 'package:flutter/material.dart';
import 'package:shomineh/config/theme/AppTheme.dart';

/// specified tag for PhoneScreen
const String LIST_SCREEN = "/Login";
const String HOME_SCREEN = "/Main";


/// minimum length of Username that user should enter
const int USER_MIN_LENGTH = 4;

const double WIDTH_THRESHOLD = 500;
const double WIDTH_THRESHOLD_MOBILE = 500;



double get bottomNavigationVisibleHeight => 68;

double get bottomNavigationHeight => 80;

double get headerHeight => 50;


const double minTemp = 16;
const double maxTemp = 35;

String get allNumbersRegex => r'[0-9\u06F0-\u06FF]';

String get persianCharactersRegex => r'[\u0600-\u06EF]';

String get englishCharactersRegex => r'[A-Za-z]';

String get phoneFormatRegex => r'^09\d{9}';

String get timeStampRegex => r'^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}$';

String get passwordFormatRegex => r"^(?=.*[A-Za-z])(?=.*\d).{8,20}$";

const englishNumbers = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
const farsiNumbers = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];


const double TITLE_SIZE = 40;

const double BOTTOM_OFFSET = 16;

const double HEIGHT = 640;
const double WIDTH = 360;

const double ITEM_WIDTH = 224;

const double TITLEBAR_HEIGHT = 32;
const double BUTTON_HEIGHT = 52;

const basePadding = EdgeInsets.only(right: 16, left: 16);


const double PADDING_SIDE = 16;
const double PADDING_SIDE_BIG = 33;


const EdgeInsets BASE_PADDING = EdgeInsets.only(right: 8, left: 0);

class RadiusSize {
  RadiusSize._();

  static const double r2xs = 0;
  static const double rxs = 2;
  static const double rsm = 4;
  static const double rmd = 8;
  static const double rlg = 12;
  static const double rxl = 16;
  static const double rFull = 96;
}

class PaddingSize {
  PaddingSize._();

  static const double pxs = 4;
  static const double psm = 8;
  static const double pmd = 12;
  static const double plg = 16;
  static const double pxl = 24;
  static const double p2xl = 32;
  static const double p3xl = 40;
}

class GapSize {
  GapSize._();

  static const double g2xs = 0;
  static const double gxs = 4;
  static const double gsm = 8;
  static const double gmd = 12;
  static const double glg = 16;
  static const double gxl = 24;
  static const double g2xl = 32;
  static const double g3xl = 40;
}
