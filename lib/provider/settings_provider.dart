// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:asl/constants/key_value_names.dart';
import 'package:asl/services/services.dart';

enum TypeDisplay {
  pageView,
  imageSwitcher,
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, SettingsState>(
  (ref) => SettingsNotifier(),
);

class SettingsNotifier extends StateNotifier<SettingsState> {
  final keyValueStorageService = KeyValueStorageServiceImpl();
  SettingsNotifier()
      : super(
          SettingsState(
            isDarkMode: false,
            isSoundActive: true,
            isVibrationActive: true,
            transitionTime: 750.0,
            sliderDirection: Axis.horizontal,
            selectedAxiosOption: 0,
            typeDisplay: TypeDisplay.pageView,
            color: Colors.blue,
            isMainDisplayInPageView: false,
            isTurned: false,
          ),
        ) {
    asyncInit();
  }

  void asyncInit() async {
    final isDarkMode = await keyValueStorageService.getValue<bool>(IS_DARKMODE);
    final isSoundActive =
        await keyValueStorageService.getValue<bool>(IS_SOUNDACTIVE);
    final isVibrationActive =
        await keyValueStorageService.getValue<bool>(IS_VIBRATIONACTIVE);
    final transitionTime =
        await keyValueStorageService.getValue<double>(TRANSITION_TIME);
    final color = await keyValueStorageService.getValue<int>(COLOR_HANDS);
    final selectedDisplayOption =
        await keyValueStorageService.getValue<int>(TYPE_DISPLAY);

    final selectedAxiosOption =
        await keyValueStorageService.getValue<int>(SELECTED_AXIOS_OPTION);
    final isMainDisplayInPageView = await keyValueStorageService
        .getValue<bool>(IS_MAIN_DISPLAY_IN_PAGE_VIEW);
    final isTurned = await keyValueStorageService.getValue<bool>(IS_TURNED);

    state = state.copyWith(
      isDarkMode: isDarkMode ?? state.isDarkMode,
      isSoundActive: isSoundActive ?? state.isSoundActive,
      isVibrationActive: isVibrationActive ?? state.isVibrationActive,
      transitionTime: transitionTime ?? state.transitionTime,
      selectedAxiosOption: selectedAxiosOption ?? state.selectedAxiosOption,
      color: Color(color ?? state.color.value),
      isMainDisplayInPageView:
          isMainDisplayInPageView ?? state.isMainDisplayInPageView,
      isTurned: isTurned ?? state.isTurned,
    );
    setSelectedDisplayOption(
        selectedDisplayOption ?? state.selectedAxiosOption);
  }

  void toggleDarkMode() async {
    state = state.copyWith(isDarkMode: !state.isDarkMode);
    await keyValueStorageService.setKeyValue<bool>(
        IS_DARKMODE, state.isDarkMode);
  }

  void toggleSound() async {
    state = state.copyWith(isSoundActive: !state.isSoundActive);
    await keyValueStorageService.setKeyValue<bool>(
        IS_SOUNDACTIVE, state.isSoundActive);
  }

  void toggleVibration() async {
    state = state.copyWith(isVibrationActive: !state.isVibrationActive);
    await keyValueStorageService.setKeyValue<bool>(
        IS_VIBRATIONACTIVE, state.isVibrationActive);
  }

  Future<void> toggleMainDisplayInPageView() async {
    state =
        state.copyWith(isMainDisplayInPageView: !state.isMainDisplayInPageView);
    await keyValueStorageService.setKeyValue<bool>(
        IS_MAIN_DISPLAY_IN_PAGE_VIEW, state.isMainDisplayInPageView);
  }

  void setTransitionTime(double value) async {
    state = state.copyWith(transitionTime: value);
    await keyValueStorageService.setKeyValue<double>(TRANSITION_TIME, value);
  }

  void setIconColor(Color color) async {
    state = state.copyWith(color: color);
    await keyValueStorageService.setKeyValue<int>(COLOR_HANDS, color.value);
  }

  void changeIndeState(int index) {
    state = state.copyWith();
  }

  void setSelectedDisplayOption(int value) async {
    switch (value) {
      case 0:
        state = state.copyWith(
          sliderDirection: Axis.horizontal,
          selectedAxiosOption: value,
          typeDisplay: TypeDisplay.pageView,
        );
        break;
      case 1:
        state = state.copyWith(
            sliderDirection: Axis.vertical,
            selectedAxiosOption: value,
            typeDisplay: TypeDisplay.pageView);
        break;
      case 2:
        state = state.copyWith(
            sliderDirection: Axis.vertical,
            selectedAxiosOption: value,
            typeDisplay: TypeDisplay.imageSwitcher);
        break;
      default:
        state = state.copyWith(
            sliderDirection: Axis.horizontal, selectedAxiosOption: value);
    }
    await keyValueStorageService.setKeyValue<int>(TYPE_DISPLAY, value);
  }

  void playSoundAndVibration(String assetPath) {
    if (state.isVibrationActive) {
      this.startVibrate();
    }
    if (state.isSoundActive) {
      this.playSound(assetPath);
    }
  }

  void playSound(String assetPath) {
    if (state.isSoundActive) {
      SoundServiceImpl().playSound(assetPath);
    }
  }

  void startVibrate({int millisec = 150}) {
    if (state.isVibrationActive) {
      VibrateServiceImp().vibrate(millisec: millisec);
    }
  }

  void setIsTurned() async {
    state = state.copyWith(isTurned: !state.isTurned);
    await keyValueStorageService.setKeyValue<bool>(IS_TURNED, state.isTurned);
  }
}

class SettingsState {
  final bool isDarkMode;
  final bool isSoundActive;
  final bool isVibrationActive;
  final double transitionTime;
  final Axis sliderDirection;
  final TypeDisplay typeDisplay;
  final int selectedAxiosOption;
  final Color color;
  final bool isMainDisplayInPageView;
  final bool isTurned;

  SettingsState({
    required this.isDarkMode,
    required this.isSoundActive,
    required this.isVibrationActive,
    required this.transitionTime,
    required this.sliderDirection,
    required this.selectedAxiosOption,
    required this.typeDisplay,
    required this.color,
    required this.isMainDisplayInPageView,
    required this.isTurned,
  });

  SettingsState copyWith({
    bool? isDarkMode,
    bool? isSoundActive,
    bool? isVibrationActive,
    double? transitionTime,
    Axis? sliderDirection,
    TypeDisplay? typeDisplay,
    int? selectedAxiosOption,
    Color? color,
    bool? isMainDisplayInPageView,
    bool? isTurned,
  }) {
    return SettingsState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      isSoundActive: isSoundActive ?? this.isSoundActive,
      isVibrationActive: isVibrationActive ?? this.isVibrationActive,
      transitionTime: transitionTime ?? this.transitionTime,
      sliderDirection: sliderDirection ?? this.sliderDirection,
      typeDisplay: typeDisplay ?? this.typeDisplay,
      selectedAxiosOption: selectedAxiosOption ?? this.selectedAxiosOption,
      color: color ?? this.color,
      isMainDisplayInPageView:
          isMainDisplayInPageView ?? this.isMainDisplayInPageView,
      isTurned: isTurned ?? this.isTurned,
    );
  }
}
