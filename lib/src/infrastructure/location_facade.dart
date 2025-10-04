import 'package:location/location.dart';
import 'package:shomineh/di/DiHelper.dart';

class LocationFacade {
  static LocationFacade get instance => DiHelper.locationFacade;

  late Location _location;

  LocationFacade() {
    _location = Location();
  }

  Future<bool> isServiceEnabled() {
    return _location.serviceEnabled();
  }

  Future<bool> enableService() {
    return _location.requestService();
  }

  Future<PermissionStatus> checkPermission() {
    return _location.requestPermission();
  }

  Future<bool> hasPermission() async {
    return (await _location.hasPermission()) == PermissionStatus.granted;
  }
}
