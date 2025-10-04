

import 'package:shomineh/di/DiHelper.dart';

class BuildConfig{

  static BuildConfig get instance => DiHelper.buildConfig;

  late BuildEnvironmentType _envType;
  BuildEnvironmentType get envType => _envType;

  BuildConfig(){

    String env = const String.fromEnvironment('env', defaultValue: 'dev');

    if(env.toLowerCase().startsWith("production")){
      _envType = BuildEnvironmentType.release;
    } else if(env.toLowerCase().contains("dev")){
      _envType = BuildEnvironmentType.releaseTest;
    } else {
      _envType = BuildEnvironmentType.debug;
    }

  }


}

enum BuildEnvironmentType{
  debug, release, releaseTest;

  bool get envIsDebug => this == debug;
  bool get envIsRelease => this == release;
  bool get envIsReleaseTest => this == releaseTest;

}