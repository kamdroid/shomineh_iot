import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:shomineh/src/data/data_sources/ibluetooth_connection_datasource.dart';
import 'package:shomineh/src/data/data_sources/ilocation_datasource.dart';
import 'package:shomineh/src/infrastructure/bluetooth/bluetooth.dart';
import 'package:shomineh/src/infrastructure/location_facade.dart';

class LocationDatasource implements ILocationDatasource {

  final LocationFacade locationFacade;
  LocationDatasource(this.locationFacade);

  @override
  Future<bool> enableService() async {
    return await locationFacade.enableService();
  }

  @override
  Future<bool> isServiceEnabled() async {
    return await locationFacade.isServiceEnabled();
  }


}
