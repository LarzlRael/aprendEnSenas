// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:asl/services/services.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_provider.g.dart';

enum TypeDisplay {
  pageView,
  imageSwitcher,
}

@riverpod
class SettingsProvider extends _$SettingsProvider {
  @override
  ProviderState build() {
    return initBuild();
  }

  ProviderState initBuild() {
    return ProviderState(
        false, false, false, 0.0, Axis.horizontal, 0, TypeDisplay.pageView);
  }

  void toggleDarkMode() {
    state = state.copyWith(isDarkMode: !state.isDarkMode);
  }

  void toggleSound() {
    state = state.copyWith(isSoundActive: !state.isSoundActive);
  }

  void toggleVibration() {
    state = state.copyWith(isVibrationActive: !state.isVibrationActive);
  }

  void setTransitionTime(double value) {
    state = state.copyWith(transitionTime: value);
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
      this.typeDisplay);

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
