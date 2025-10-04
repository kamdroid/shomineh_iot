import 'package:flutter/material.dart';
import 'package:shomineh/config/constants/Constants.dart';
import 'package:shomineh/config/resources/Images.dart';
import 'package:shomineh/config/resources/Strings.dart';
import 'package:shomineh/config/theme/AppTheme.dart';
import 'package:shomineh/navigation/Navigation.dart';
import 'package:shomineh/src/ui/base/BaseStateless.dart';
import 'package:shomineh/src/ui/screens/fireplace/FirePlaceState.dart';
import 'package:shomineh/src/ui/screens/fireplace/FireplaceProvider.dart';
import 'package:shomineh/src/ui/screens/fireplace/FireplaceRow.dart';
import 'package:shomineh/src/ui/widgets/BaseScaffold.dart';
import 'package:shomineh/src/ui/widgets/ButtonApp.dart';
import 'package:shomineh/src/ui/widgets/ColorPalletView.dart';
import 'package:shomineh/src/ui/widgets/CustomSlider.dart';
import 'package:shomineh/src/ui/widgets/CustomSwitch.dart';
import 'package:shomineh/src/ui/widgets/HeaderView.dart';
import 'package:shomineh/src/ui/widgets/MultiColorText.dart';
import 'package:shomineh/src/ui/widgets/Space.dart';
import 'package:shomineh/src/ui/widgets/TemperatureView.dart';

class FireplaceScreen extends BaseStateless<FireplaceProvider, FirePlaceState> {
  FireplaceScreen({super.key});


  static void open(){
    Navigation.instance.gotoWithRouteNoContext(FireplaceScreen());
  }

  @override
  Widget buildUi(BuildContext context, uiState) {
    return BaseScaffold(
      showLoading: uiState.loadingPool,
      header: HeaderView(
        title: MultiColorText(
          texts: [
            Strings.fireplaceFa,
            Strings.fireplaceEn,
          ],
          textStyle: [
            AppTheme.fonts.faRegularLg(),
            AppTheme.fonts.faRegularMd(
                color: AppTheme.colors.whiteColor.withValues(alpha: 0.7)),
          ],
        ),
        menu: Images.instance.getImageSvg('arrow_left'),
        menuAction: providerModel.goBack,
        // menuActionRight: providerModel.deleteDevice,
      ),
      child: ValueListenableBuilder(
        valueListenable: uiState.loadingPool,
        builder: (context, loading, _) {
          return SingleChildScrollView(
            child: Column(
                children: [
                  const Space(
                    height: 24,
                  ),
                  Container(
                      width: 170,
                      height: 46,
                      decoration: AppTheme.containerBorder(
                          cornerCurve: 12, color: AppTheme.colors.cardBackground),
                      padding:
                      const EdgeInsets.only(top: 8, bottom: 8, left: 24, right: 24),
                      child: ValueListenableBuilder(
                          valueListenable: uiState.switchValue,
                          builder: (context, switchValue, _) {
                            return CustomSwitch(
                              value: switchValue,
                              onChanged: providerModel.onFirePlaceChanged,
                            );
                          }
                      )),
                  const Space(
                    height: 24,
                  ),
                  ValueListenableBuilder(
                      valueListenable: uiState.temperature,
                      builder: (context, temperature, _) {
                        return temperatureView(
                            temperature: temperature, title: "دمای شومینه");
                      }
                  ),
                  const Space(
                    height: 24,
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        Strings.enterFireplaceHeat,
                        style: AppTheme.fonts.faRegularXs(),
                      )),
                  const Space(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 28, left: 28),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ValueListenableBuilder(
                            valueListenable: uiState.heaterStatus,
                            builder: (context, heaterStatus, _) {
                              return ButtonApp(
                                width: 80,
                                textStyle: AppTheme.fonts.faRegularSm(),
                                text: Strings.low,
                                cornerCurve: 12,
                                decoration: heaterStatus.isLow
                                    ? null
                                    : AppTheme.containerBorder(
                                    cornerCurve: 12, color: AppTheme.colors.deactiveColor),
                                onButtonPressed: providerModel.setHeaterLow,
                              );
                            }
                        ),
                        const Space(
                          width: 24,
                        ),
                        ValueListenableBuilder(
                            valueListenable: uiState.heaterStatus,
                            builder: (context, heaterStatus, _) {
                              return ButtonApp(
                                width: 80,
                                textStyle: AppTheme.fonts.faRegularSm(),
                                text: Strings.high,
                                cornerCurve: 12,
                                decoration: heaterStatus.isHigh
                                    ? null
                                    : AppTheme.containerBorder(
                                    cornerCurve: 12, color: AppTheme.colors.deactiveColor),
                                onButtonPressed: providerModel.setHeaterHigh,
                              );
                            }
                        ),
                        const Space(
                          width: 24,
                        ),
                        ValueListenableBuilder(
                            valueListenable: uiState.heaterStatus,
                            builder: (context, heaterStatus, _) {
                              return ButtonApp(
                                width: 84,
                                textStyle: AppTheme.fonts.faRegularSm(),
                                text: Strings.automatic,
                                cornerCurve: 12,
                                decoration: heaterStatus.isAuto
                                    ? null
                                    : AppTheme.containerBorder(
                                    cornerCurve: 12, color: AppTheme.colors.deactiveColor),
                                onButtonPressed: providerModel.setHeaterAuto,
                              );
                            }
                        ),
                      ],
                    ),
                  ),
                  const Space(
                    height: 20,
                  ),
                  ValueListenableBuilder(
                      valueListenable: uiState.fireplaceValue,
                      builder: (context, fireplaceValue, _) {
                      return ValueListenableBuilder(
                          valueListenable: uiState.switchValue,
                          builder: (context, switchValue, _) {
                            return ValueListenableBuilder(
                                valueListenable: uiState.heaterStatus,
                                builder: (context, heaterStatus, _) {
                                  return CustomSlider(
                                    min: minTemp,
                                    max: maxTemp,
                                    isEnable: providerModel.pageEnable,
                                    decoration: heaterStatus.isAuto
                                        ? null
                                        : AppTheme.containerBorder(
                                      cornerCurve: 8,
                                      color: AppTheme.colors.Grey,
                                    ),
                                    value: fireplaceValue,
                                    onChanged: providerModel.onFirePlaceHeatChanged,
                                  );
                                }
                            );
                          }
                      );
                    }
                  ),
                  const Space(
                    height: 26,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        Strings.enterFireColor,
                        style: AppTheme.fonts.faRegularXs(),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          if (providerModel.pageEnable) {
                            providerModel.selectColor();
                          }
                        },
                        child: Text(
                          Strings.pickFireColor,
                          style: AppTheme.fonts
                              .faRegularXs(color: AppTheme.colors.greenLight),
                        ),
                      ),
                      const Space(),
                      Images.instance.getSizedImageSvg('arrow_left',
                          color: AppTheme.colors.greenLight, width: 16, height: 16)
                    ],
                  ),
                  const Space(
                    height: 32,
                  ),
                  SizedBox(
                    width: 224,
                    height: 65,
                    child: GestureDetector(
                      onTap: () {
                        if (providerModel.pageEnable) {
                          providerModel.onFirePlaceActivationChanged();
                        }
                      },
                      child: Stack(
                        children: [
                          Images.instance
                              .getSizedImageSvg('fire_frame', width: 224, height: 65),
                          Positioned(
                              bottom: 10,
                              right: 20,
                              child: ValueListenableBuilder(
                                  valueListenable: uiState.selectedColor,
                                  builder: (context, selectedColor, _) {
                                  return ValueListenableBuilder(
                                      valueListenable: uiState.fireColorIndex,
                                      builder: (context, fireColorIndex, _) {
                                      return Images.instance.getSizedImageSvg('fire_place',
                                          width: 184,
                                          height:
                                          /*providerModel.fireColorIndex == -100 ? 0 : */ 32,
                                          color: providerModel.fireColor);
                                    }
                                  );
                                }
                              )),
                          Positioned(
                            bottom: 5,
                            right: 16,
                            child: ValueListenableBuilder(
                                valueListenable: uiState.fireplaceEnable,
                                builder: (context, fireplaceEnable, _) {
                                  return Container(
                                    width: 192,
                                    height: 5,
                                    decoration: AppTheme.containerBorder(
                                        cornerCurve: 2,
                                        color: fireplaceEnable
                                            ? AppTheme.colors.fireActive
                                            : AppTheme.colors.inactiveColor),
                                  );
                                }
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const Space(),
                  Center(
                    child: Text(
                      Strings.fireSwitchText,
                      style: AppTheme.fonts.faRegular2xs(),
                    ),
                  ),
                  const Space(
                    height: 16,
                  ),
                  ValueListenableBuilder(
                      valueListenable: uiState.fireColorIndex,
                      builder: (context, fireColorIndex, _) {
                      return ValueListenableBuilder(
                          valueListenable: uiState.switchValue,
                          builder: (context, switchValue, _) {
                            return ColorPalletView(
                              colors: providerModel.fireColorList,
                              selectedIndex: fireColorIndex,
                              isEnable: providerModel.pageEnable,
                              onSelectColor: providerModel.onFirePlaceColorSelected,
                            );
                          }
                      );
                    }
                  ),
                  const Space(
                    height: 20,
                  ),
                  ValueListenableBuilder(
                      valueListenable: uiState.switchValue,
                      builder: (context, switchValue, _) {
                        return ValueListenableBuilder(
                            valueListenable: uiState.speaker,
                            builder: (context, speaker, _) {
                              return fireplaceRowInfo(
                                  imageNAme: 'speaker',
                                  title: Strings.fireSound,
                                  info: providerModel.fireVolume,
                                  isEnable: providerModel.pageEnable,
                                  onTap: providerModel.setFireVolume);
                            }
                        );
                      }
                  ),
                  const Space(
                    height: 16,
                  ),
                  ValueListenableBuilder(
                      valueListenable: uiState.playMobileSwitchValue,
                      builder: (context, playMobileSwitchValue, _) {
                      return ValueListenableBuilder(
                          valueListenable: uiState.switchValue,
                          builder: (context, switchValue, _) {
                            return fireplaceRowSwitch(
                                imageNAme: 'sun',
                                title: Strings.playSoundThroughMobile,
                                value: playMobileSwitchValue,
                                isEnable: providerModel.pageEnable,
                                onChanged: providerModel.onPlayMobileSoundStateChanged);
                          }
                      );
                    }
                  ),
                  const Space(
                    height: 16,
                  ),
                  ValueListenableBuilder(
                      valueListenable: uiState.switchValue,
                      builder: (context, switchValue, _) {
                        return ValueListenableBuilder(
                            valueListenable: uiState.light,
                            builder: (context, light, _) {
                              return fireplaceRowInfo(
                                  imageNAme: 'sun',
                                  isEnable: providerModel.pageEnable,
                                  title: Strings.fireLight,
                                  info: providerModel.fireLight,
                                  onTap: providerModel.setFireLight);
                            });
                      }
                  ),
                  const Space(
                    height: 20,
                  ),
                ]
            ),
          );
        }
      ),
    );
  }
}
