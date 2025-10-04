import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:shomineh/config/base/BuildConfig.dart';
import 'package:shomineh/config/constants/Constants.dart';
import 'package:shomineh/src/data/mappers/StringMapper.dart';
import 'package:shomineh/src/data/models/base/Triple.dart';

/// checks [number] format if it's started with +98. unless it removes 0 at the beginning and add +98.
String phoneNumberFormat(String number) {
  String phone;
  if (number.startsWith("0")) {
    phone = "+98${number.substring(1)}";
  } else {
    phone = number;
  }
  return phone;
}

/// opens and reads text file in assets. It converts the json into hashmap and returns the hashmap.
Future<Map<dynamic, dynamic>> getStrings(BuildContext context) async {
  var source = await DefaultAssetBundle.of(context)
      .loadString("assets/strings/text.json");

  return Future.value(json.decode(source));
}

/// converts [time] which is in long into string with special format of : HH:mm:ss.
String millisecondToString(int time) {
  int remain = time ~/ 1000;
  int second = remain.remainder(60);
  int min = remain ~/ 60;
  int hour = min ~/ 60;
  min = min.remainder(60);

  return "${hour.toString().padLeft(2, '0')}:${min.toString().padLeft(2, '0')}:${second.toString().padLeft(2, '0')}";
}

/// closes soft key if it already opened.
void closeKeypad() {
  if (isTargetPhone) {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}

void printMessage(String message, {bool showInRelease = false}) {
  if (!BuildConfig.instance.envType.envIsRelease || showInRelease) {
    print(message);
  }
}

Future delay({int millisecond = 250}) =>
    Future.delayed(Duration(milliseconds: millisecond));

void delaySafe({int millisecond = 250, Function()? action}) =>
    Timer(Duration(milliseconds: millisecond), () {
      action?.call();
    });

Timer delayDuration(
        {Duration duration = const Duration(milliseconds: 250),
        Function()? action}) =>
    Timer(duration, () {
      action?.call();
    });

double getScreenHeightNoStatusBar(BuildContext context) {
  final query = MediaQuery.of(context);

  return query.size.height - query.viewPadding.top - query.viewPadding.bottom;
}

double getRestHeightWithTopic(BuildContext context, {double any = 0}) {
// 56 is the default Padding of every page defined in HeaderWidget

  final val = getScreenHeightNoStatusBar(context) - 148 - any;
  return val;
}

bool get isTargetAndroid => defaultTargetPlatform == TargetPlatform.android;

bool get isTargetIos => defaultTargetPlatform == TargetPlatform.iOS;

bool get isTargetAndroidApp =>
    defaultTargetPlatform == TargetPlatform.android && !kIsWeb;

bool get isTargetPhone => (isTargetAndroid || isTargetIos) && !kIsWeb;

String removeSecondsFromDate(String date) {
  final pos = date.lastIndexOf(":");
  if (pos < 0) return date;
  return date.substring(0, pos);
}

String toHourText(int time) {
  int min = time ~/ 60;
  int hour = min ~/ 60;
  min %= 60;

  return "${hour}h ${min}m";
}

bool isPhoneFormatCorrect(String phone) {
  final format = RegExp(phoneFormatRegex);

  return format.hasMatch(phone.toEnglishNumber);
}

bool isPasswordFormatCorrect(String password) {
  final format = RegExp(passwordFormatRegex);

  return format.hasMatch(password);
}

bool isEmailFormatCorrect(String email) {
  final format = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  return format.hasMatch(email);
}

String phoneToCorrectFormat(String phone) {
  return phone.replaceAll(RegExp('\\(|\\)'), "").replaceAll("+98", "0");
}

Timer getCountDownTimerBySeparatedTime(
    {int hour = 0,
    int minute = 0,
    int second = 0,
    int tickerSecond = 1,
    Function(String)? onTick,
    Function(int)? onFinished}) {
  return getCountDownTimer(
      totalPeriod: (hour * 60 + minute) * 60 + second,
      tickerSecond: tickerSecond,
      onTick: (time) {
        onTick?.call(intToStringTime(time));
      },
      onFinished: onFinished);
}

String intToStringTime(int tick) {
  final timeElements = intToTime(tick);

  String time;

  if (timeElements.first > 0) {
    time =
        "${timeElements.first.toString().padLeft(2, '0')}:${timeElements.second.toString().padLeft(2, '0')}:${timeElements.third.toString().padLeft(2, '0')}";
  } else {
    time =
        "${timeElements.second.toString().padLeft(2, '0')}:${timeElements.third.toString().padLeft(2, '0')}";
  }

  return time;
}

Timer getCountDownTimer(
    {int totalPeriod = 120,
    int tickerSecond = 1,
    Function(int)? onTick,
    Function(int)? onFinished}) {
  int timeInSeconds = totalPeriod;
  return Timer.periodic(Duration(seconds: tickerSecond), (timer) {
    if (timeInSeconds <= 0) {
      timer.cancel();
      onFinished?.call(timeInSeconds);
    } else {
      timeInSeconds -= tickerSecond;
      onTick?.call(timeInSeconds);
    }
  });
}

Triple<int, int, int> intToTime(int number) {
  final sec = number % 60;
  final byMin = (number ~/ 60);
  final min = byMin % 60;
  final hour = (byMin ~/ 60);

  return Triple(hour, min, sec);
}

String setPlacement(String main, String placement, {String splitter = "*"}) {
  return main.replaceAll(splitter, placement);
}

String setPlacements(String main, List<String> placement,
    {String splitter = "*"}) {
  final parts = main.split(splitter);
  String output = "";
  int pos = 0;

  for (; pos < parts.length; pos++) {
    String place = "";
    if (pos < placement.length) {
      place = placement[pos];
    }

    output += "${parts[pos]}$place";
  }

  for (; pos < placement.length; pos++) {
    output += placement[pos];
  }

  return output;
}

String toDateFormat(String date,
    {String splitter = "-", String separator = "-"}) {
  final time = date.split(splitter);
  return "${time[2]}$separator${time[1]}$separator${time[0]}";
}

String toDateFormatLtr(String date,
    {String splitter = "-", String separator = "-"}) {
  final time = date.split(splitter);
  return "${time[0]}$separator${time[1]}$separator${time[2]}";
}

Map<String, String> stringToHashMap(String data) {
  if (data.isEmpty) {
    return {};
  }

  String order = data.replaceAll("G", "\nG");

  if(data.contains("B")) {
    order = order.replaceAll("FB", "ZZ").replaceAll("B", "\nB").replaceAll("ZZ", "FB");
  }


  final map = Map<String, String>.fromIterable(order.split('\n').where((item) => item.isNotEmpty), key: (item) {
    int pos = item.indexOf(RegExp(r'[0-9]'));
    if(pos == -1){
      pos = 0;
    }
    printMessage("key pos: $pos");
    return item.substring(0, pos);
  }, value: (item) {
    int pos = item.indexOf(RegExp(r'[0-9]'));
    if(pos == -1){
      pos = 0;
    }
    printMessage("item pos: $pos");
    return item.substring(pos);
  });

  return map;
}
