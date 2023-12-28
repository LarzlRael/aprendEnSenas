// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_provider.g.dart';

@riverpod
class SettingsProvider extends _$SettingsProvider {
  @override
  ProviderState build() {
    return ProviderState(false, false, false, 0.0, Axis.horizontal, 0);
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

  void setSliderDirection(Axis value) {
    state = state.copyWith(sliderDirection: value);
  }

  void setSelectedAxiosOption(int value) {
    state = state.copyWith(selectedAxiosOption: value);
  }
}

class ProviderState {
  final bool isDarkMode;
  final bool isSoundActive;
  final bool isVibrationActive;
  final double transitionTime;
  final Axis sliderDirection;
  final int selectedAxiosOption;

  ProviderState(this.isDarkMode, this.isSoundActive, this.isVibrationActive,
      this.transitionTime, this.sliderDirection, this.selectedAxiosOption);

  ProviderState copyWith({
    bool? isDarkMode,
    bool? isSoundActive,
    bool? isVibrationActive,
    double? transitionTime,
    Axis? sliderDirection,
    int? selectedAxiosOption,
  }) {
    return ProviderState(
      isDarkMode ?? this.isDarkMode,
      isSoundActive ?? this.isSoundActive,
      isVibrationActive ?? this.isVibrationActive,
      transitionTime ?? this.transitionTime,
      sliderDirection ?? this.sliderDirection,
      selectedAxiosOption ?? this.selectedAxiosOption,
    );
  }
}
