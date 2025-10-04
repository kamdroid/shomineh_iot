

import 'package:shomineh/config/base/BuildConfig.dart';
import 'package:shomineh/config/resources/base/DevUrls.dart';
import 'package:shomineh/config/resources/base/ProductionUrls.dart';
import 'package:shomineh/di/DiHelper.dart';
import 'package:shomineh/config/resources/base/UrlInterface.dart';

class Urls implements UrlInterface{
  static Urls get instance => DiHelper.urls;

  final BuildConfig buildConfig;

  late UrlInterface url;

  Urls(this.buildConfig){

    if(buildConfig.envType.envIsRelease){
      url = ProductionUrls();
    } else {
      url = DevUrls();
    }
  }

  @override
  String get base => url.base;


}

class ActionsName {
  ActionsName._();
}

class Credential {
  Credential._();

  static const String yekan = "yekan";

  static const String notificationGroupKey = "it_GroupKey";
  static const String notificationChannelKey = "it_ChannelKey";
  static const String notificationChannelName = "itInfo";

  static const String notificationGroupName = "it_InfoGroup";

  static const String darkTheme = "darkTheme";
  static const String lightTheme = "lightTheme";
  static const String serviceUuid = "55535343-fe7d-4ae5-8fa9-9fafd205e455";

}

class Events {
  Events._();
}
