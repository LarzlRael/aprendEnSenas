// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:asl/services/services.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_provider.g.dart';

const IS_DARKMODE = "IS_DARK_MODE";
const IS_SOUNDACTIVE = "IS_SOUND_ACTIVE";
const IS_VIBRATIONACTIVE = "IS_VIBRATION_ACTIVE";
const TRANSITION_TIME = "TRANSITION_TIME";
const SLIDER_DIRECTION = "SLIDER_DIRECTION";
const SELECTED_AXIOS_OPTION = "SELECTED_AXIOS_OPTION";
const TYPE_DISPLAY = "TYPE_DISPLAY";

enum TypeDisplay {
  pageView,
  imageSwitcher,
}

@riverpod
class Settings extends _$Settings {
  final keyValueStorageService = KeyValueStorageServiceImpl();
  @override
  ProviderState build() {
    return ProviderState(
      true,
      true,
      true,
      0.0,
      Axis.horizontal,
      0,
      TypeDisplay.pageView,
    );
  }

  Future<ProviderState> initBuildAsync() async {
    bool isDarkMode =
        await keyValueStorageService.getValue<bool>(IS_DARKMODE) ?? false;
    bool isSoundActive =
        await keyValueStorageService.getValue<bool>(IS_SOUNDACTIVE) ?? false;
    bool isVibrationActive =
        await keyValueStorageService.getValue<bool>(IS_VIBRATIONACTIVE) ??
            false;
    double transitionTime =
        await keyValueStorageService.getValue<double>(TRANSITION_TIME) ?? 0.0;
    /* Axis sliderDirection = Axis.horizontal; // Ajusta según sea necesario
    int selectedAxiosOption =
        await keyValueStorageService.getValue<int>(SELECTED_AXIOS_OPTION) ??
            0;
    TypeDisplay typeDisplay =
        TypeDisplay.pageView; // Ajusta según sea necesario */

    return ProviderState(
      isDarkMode,
      isSoundActive,
      isVibrationActive,
      transitionTime,
      Axis.horizontal,
      0,
      TypeDisplay.pageView,
      /* sliderDirection,
      selectedAxiosOption,
      typeDisplay, */
    );
  }

  Future<void> initializeStateAsync() async {
    state = await initBuildAsync();
  }

  void initializeState() {
    initializeStateAsync();
  }

  void toggleDarkMode() async {
    state = state.copyWith(isDarkMode: !state.isDarkMode);
    await keyValueStorageService.setKeyValue<bool>(
        IS_DARKMODE, !state.isDarkMode);
  }

  void toggleSound() async {
    state = state.copyWith(isSoundActive: !state.isSoundActive);
    await keyValueStorageService.setKeyValue<bool>(
        IS_SOUNDACTIVE, !state.isSoundActive);
  }

  void toggleVibration() async {
    state = state.copyWith(isVibrationActive: !state.isVibrationActive);
    await keyValueStorageService.setKeyValue<bool>(
        IS_VIBRATIONACTIVE, !state.isVibrationActive);
  }

  void setTransitionTime(double value) async {
    state = state.copyWith(transitionTime: value);
    await keyValueStorageService.setKeyValue<double>(TRANSITION_TIME, value);
  }

  void setSelectedDisplayOption(int value) {
    switch (value) {
      case 0:
        state = state.copyWith(
            sliderDirection: Axis.horizontal,
            selectedAxiosOption: value,
            typeDisplay: TypeDisplay.pageView);
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

  void startVibrate({int millisec = 500}) {
    if (state.isVibrationActive) {
      VibrateServiceImp().vibrate(millisec: millisec);
    }
  }
}

class ProviderState {
  final bool isDarkMode;
  final bool isSoundActive;
  final bool isVibrationActive;
  final double transitionTime;
  final Axis sliderDirection;
  final int selectedAxiosOption;
  final TypeDisplay typeDisplay;

  ProviderState(
    this.isDarkMode,
    this.isSoundActive,
    this.isVibrationActive,
    this.transitionTime,
    this.sliderDirection,
    this.selectedAxiosOption,
    this.typeDisplay,
  );

  ProviderState copyWith({
    bool? isDarkMode,
    bool? isSoundActive,
    bool? isVibrationActive,
    double? transitionTime,
    Axis? sliderDirection,
    int? selectedAxiosOption,
    TypeDisplay? typeDisplay,
  }) {
    return ProviderState(
      isDarkMode ?? this.isDarkMode,
      isSoundActive ?? this.isSoundActive,
      isVibrationActive ?? this.isVibrationActive,
      transitionTime ?? this.transitionTime,
      sliderDirection ?? this.sliderDirection,
      selectedAxiosOption ?? this.selectedAxiosOption,
      typeDisplay ?? this.typeDisplay,
    );
  }
}
