

import 'package:shomineh/common/Util.dart';
import 'package:shomineh/config/base/baseUiState.dart';
import 'package:shomineh/src/ui/base/BaseProvider.dart';

abstract class BaseProviderForStateless<T extends BaseUiState> extends BaseProvider<T> {
  BaseProviderForStateless(super.uiState);


  @override
  void goBack<R>({R? result}) {
    printMessage("-*-*-*-*-*-* goBack pressed");
    clearAll();
    super.goBack(result: result);
  }

}
