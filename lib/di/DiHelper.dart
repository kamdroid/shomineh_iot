import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shomineh/config/base/BuildConfig.dart';
import 'package:shomineh/config/resources/Images.dart';
import 'package:shomineh/config/resources/Urls.dart';
import 'package:shomineh/config/theme/ThemeManager.dart';
import 'package:shomineh/navigation/Navigation.dart';
import 'package:shomineh/navigation/RouteGenerator.dart';
import 'package:shomineh/src/data/data_sources/ilocation_datasource.dart';
import 'package:shomineh/src/domain/data_sources/bluetooth_communication_datasource.dart';
import 'package:shomineh/src/data/data_sources/ibluetooth_communication_datasource.dart';
import 'package:shomineh/src/data/data_sources/ibluetooth_connection_datasource.dart';
import 'package:shomineh/src/domain/data_sources/bluetooth_connection_datasource.dart';
import 'package:shomineh/src/domain/data_sources/location_datasource.dart';
import 'package:shomineh/src/domain/repositories/bluetooth_communication_repository.dart';
import 'package:shomineh/src/domain/repositories/bluetooth_repository.dart';
import 'package:shomineh/src/domain/repositories/location_repository.dart';
import 'package:shomineh/src/infrastructure/bluetooth/bluetooth.dart';
import 'package:shomineh/src/infrastructure/location_facade.dart';
import 'package:shomineh/src/infrastructure/store/StoreUnit.dart';
import 'package:shomineh/src/ui/dialogs/Dialogs.dart';
import 'package:shomineh/src/ui/widgets/CommonUi.dart';

class DiHelper {
  DiHelper._();

  static GetIt get _di => GetIt.I;

  static Future<void> setupDi() async {

    _di.registerLazySingleton<BuildConfig>(() => BuildConfig());
    _di.registerLazySingleton<Urls>(() => Urls(buildConfig));

    final sharedPreferences = await SharedPreferences.getInstance();

    _di.registerLazySingleton<StoreUnit>(() => StoreUnit(sharedPreferences));

    _di.registerLazySingleton<Navigation>(() => Navigation());

    _di.registerFactory<Images>(() => Images());

    _di.registerLazySingleton<Bluetooth>(() => Bluetooth(storeUnit));

    _di.registerFactory(() => ThemeManager(storeUnit));

    _di.registerFactory(() => LocationFacade());

    _di.registerFactory<IBluetoothConnectionDatasource>(() => BluetoothConnectionDatasource(bluetooth));
    _di.registerFactory<IBluetoothCommunicationDatasource>(() => BluetoothCommunicationDatasource(bluetooth));

    _di.registerFactory<ILocationDatasource>(() => LocationDatasource(locationFacade));

    _di.registerFactory<BluetoothRepository>(() => BluetoothRepository(bluetoothConnectionDatasource));
    _di.registerFactory<LocationRepository>(() => LocationRepository(locationDatasource));
    _di.registerFactory<BluetoothCommunicationRepository>(() => BluetoothCommunicationRepository(bluetoothCommunicationDatasource));


    _di.registerFactory<Dialogs>(
            () => Dialogs(navigation.navKey.currentContext!));

    _di.registerLazySingleton<Snack>(
            () => Snack(context: navigation.navKey.currentContext!));

    _di.registerLazySingleton<RouteGenerator>(() => RouteGenerator(storeUnit));
  }

  static Navigation get navigation => _di<Navigation>();

  static Images get images => _di<Images>();

  static Bluetooth get bluetooth => _di<Bluetooth>();

  static Urls get urls => _di<Urls>();
  static StoreUnit get storeUnit => _di<StoreUnit>();
  static BuildConfig get buildConfig => _di<BuildConfig>();

  static IBluetoothConnectionDatasource get bluetoothConnectionDatasource => _di<IBluetoothConnectionDatasource>();
  static IBluetoothCommunicationDatasource get bluetoothCommunicationDatasource => _di<IBluetoothCommunicationDatasource>();

  static ILocationDatasource get locationDatasource => _di<ILocationDatasource>();

  static BluetoothRepository get bluetoothRepository => _di<BluetoothRepository>();
  static LocationRepository get locationRepository => _di<LocationRepository>();
  static BluetoothCommunicationRepository get bluetoothCommunicationRepository => _di<BluetoothCommunicationRepository>();



  static ThemeManager get themeManager => _di<ThemeManager>();

  static LocationFacade get locationFacade => _di<LocationFacade>();

  static Dialogs get dialogs => _di<Dialogs>();
  static RouteGenerator get routeGenerator => _di<RouteGenerator>();
  static Snack get snack => _di<Snack>();

}
