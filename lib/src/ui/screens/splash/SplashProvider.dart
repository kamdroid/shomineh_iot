import 'package:shomineh/common/Util.dart';
import 'package:shomineh/navigation/RouteGenerator.dart';
import 'package:shomineh/src/ui/base/BaseProviderForStateless.dart';
import 'package:shomineh/src/ui/screens/splash/SplashState.dart';

class SplashProvider extends BaseProviderForStateless<SplashState> {


  SplashProvider(): super(SplashState.init());


  @override
  void initializer() {

    delaySafe(
        millisecond: 800,
        action: () {

          _checkForExistingProject();
        });

    super.initializer();
  }

  void gotoInitScreen() {
    RouteGenerator.instance.gotoInitScreen();
  }

  void _checkForExistingProject() {
    gotoInitScreen();
    /* if (store.getToken().isNotEmpty) {
      DiHelper.loginUseCase.checkUserAccess().then((data) {
        Util.printMessage("user Access:${data.toString()}");
        gotoInitScreen(data.hasFullAccess);
      }).onError((error, stackTrace) {});
    } else {
      streamAnimation.sink.add(1);
    }*/
  }

}
