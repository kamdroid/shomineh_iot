


import 'package:shomineh/src/data/data_sources/ilocation_datasource.dart';

class LocationRepository{

  final ILocationDatasource locationDatasource;

  LocationRepository(this.locationDatasource);


  Future<bool> isServiceEnabled() async => await locationDatasource.isServiceEnabled();
  Future<bool> enableService() async => await locationDatasource.enableService();

}