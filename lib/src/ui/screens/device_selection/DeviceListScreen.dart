import 'package:flutter/material.dart';
import 'package:shomineh/common/screen_size_helper.dart';
import 'package:shomineh/config/resources/Images.dart';
import 'package:shomineh/config/resources/Strings.dart';
import 'package:shomineh/config/theme/AppTheme.dart';
import 'package:shomineh/src/ui/base/BaseStateless.dart';
import 'package:shomineh/src/ui/screens/device_selection/DeviceListProvider.dart';
import 'package:shomineh/src/ui/screens/device_selection/DeviceListState.dart';
import 'package:shomineh/src/ui/screens/splash/SplashProvider.dart';
import 'package:shomineh/src/ui/screens/splash/SplashState.dart';
import 'package:shomineh/src/ui/widgets/BaseScaffold.dart';
import 'package:shomineh/src/ui/widgets/ButtonApp.dart';
import 'package:shomineh/src/ui/widgets/HeaderView.dart';
import 'package:shomineh/src/ui/widgets/Logo.dart';
import 'package:shomineh/src/ui/widgets/Space.dart';

class DeviceListScreen
    extends BaseStateless<DeviceListProvider, DeviceListState> {
  DeviceListScreen({super.key});

  @override
  Widget buildUi(BuildContext context, uiState) {
    return BaseScaffold(
      header: HeaderView(
        title: Text(
          Strings.allBtDevices,
          style: AppTheme.fonts.faRegularLg(),
        ),
        // menuActionRight: providerModel.deleteDevice,
      ),
      showLoading: uiState.loadingPool,
      child: ValueListenableBuilder(
          valueListenable: uiState.showTurnOnBluetooth,
          builder: (context, showTurnOnBluetooth, _) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Visibility(
                    visible: !showTurnOnBluetooth,
                    child: Expanded(
                        child: ValueListenableBuilder(
                            valueListenable: uiState.devices,
                            builder: (context, devices, _) {
                              return RefreshIndicator(
                                onRefresh: providerModel.refresh,
                                child: ListView.separated(
                                    padding: const EdgeInsets.only(
                                        bottom: 12, top: 12),
                                    itemBuilder: (context, index) {
                                      final isConnected = providerModel
                                          .isDeviceConnected(devices[index]);

                                      return GestureDetector(
                                        onTap: () {
                                          providerModel
                                              .onDeviceSelected(devices[index]);
                                        },
                                        child: Card(
                                          elevation: 12,
                                          child: Container(
                                            height: 60,
                                            decoration:
                                                AppTheme.containerBorder(
                                                    cornerCurve: 8,
                                                    borderColor: AppTheme
                                                        .colors.whiteColor,
                                                    borderWidth:
                                                        isConnected ? 2 : 0,
                                                    color: AppTheme
                                                        .colors.cardBackground),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            child: SizedBox(
                                              width: ScreenSizeHelper
                                                  .getWidthDeviceRelated(),
                                              child: Row(
                                                mainAxisAlignment: isConnected
                                                    ? MainAxisAlignment
                                                        .spaceBetween
                                                    : MainAxisAlignment.end,
                                                children: [
                                                  Visibility(
                                                    visible: isConnected,
                                                    child: Images.instance
                                                        .getImageSized("paired",
                                                            width: 28,
                                                            height: 28,
                                                            color: AppTheme
                                                                .colors
                                                                .whiteColor),
                                                  ),
                                                  Text(
                                                    devices[index]
                                                        .device
                                                        .platformName,
                                                    style: AppTheme.fonts
                                                        .faBoldXs(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        const Space(
                                          height: 4,
                                        ),
                                    itemCount: devices.length),
                              );
                            })),
                  ),
                  Visibility(
                      visible: showTurnOnBluetooth && !uiState.isLoading,
                      child: ButtonApp(
                        text: Strings.turnBtOn,
                        onButtonPressed: providerModel.refresh,
                      ))
                ]);
          }),
    );
  }
}
