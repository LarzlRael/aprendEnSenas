// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:asl/utils/utils.dart';
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
            darkMode: 0,
            isSoundActive: true,
            isVibrationActive: true,
            transitionTime: 750.0,
            sliderDirection: Axis.horizontal,
            selectedAxiosOption: 0,
            typeDisplay: TypeDisplay.pageView,
            color: Colors.blue,
            isMainDisplayInPageView: false,
            isTurned: false,
            language: getSystemLanguage(),
            darkModeAux: 0,
            languageAux: getSystemLanguage(),
          ),
        ) {
    asyncInit();
  }

  void asyncInit() async {
    final darkMode = await keyValueStorageService.getValue<int>(DARKMODE);
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

    final language = await keyValueStorageService.getValue<String>(LANGUAGE);

    state = state.copyWith(
      darkMode: darkMode != null ? darkMode : state.darkMode,
      isSoundActive: isSoundActive ?? state.isSoundActive,
      isVibrationActive: isVibrationActive ?? state.isVibrationActive,
      transitionTime: transitionTime ?? state.transitionTime,
      selectedAxiosOption: selectedAxiosOption ?? state.selectedAxiosOption,
      color: Color(color ?? state.color.value),
      isMainDisplayInPageView:
          isMainDisplayInPageView ?? state.isMainDisplayInPageView,
      isTurned: isTurned ?? state.isTurned,
      language: language ?? state.language,
      languageAux: language ?? state.language,
      darkModeAux: darkMode ?? state.darkMode,
    );
    setSelectedDisplayOption(
        selectedDisplayOption ?? state.selectedAxiosOption);
  }

  Future<void> toggleTheme(int darkMode) async {
    state = state.copyWith(
      darkMode: darkMode,
    );

    await keyValueStorageService.setKeyValue<int>(
      DARKMODE,
      state.darkMode,
    );
  }

  void toggleSound() async {
    state = state.copyWith(isSoundActive: !state.isSoundActive);
    await keyValueStorageService.setKeyValue<bool>(
        IS_SOUNDACTIVE, state.isSoundActive);
  }

  bool isDarkModeEnabled() {
    var brightness = getSystemApparience();
    switch (state.darkMode) {
      case 0:
        return brightness ==
            Brightness
                .dark; // Retorna true si el brillo es oscuro, false si es claro
      case 1:
        return false; // Modo de luz, siempre retorna false
      case 2:
        return true; // Modo oscuro, siempre retorna true
      default:
        return brightness ==
            Brightness.light; // Retorna true si el brillo es oscuro por defecto
    }
  }

  Future<void> changeLanguage(String language) async {
    state = state.copyWith(language: language);
    await keyValueStorageService.setKeyValue<String>(LANGUAGE, language);
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

  void setIsThemeAux(int aux) async {
    state = state.copyWith(darkModeAux: aux);
  }

  void setLanguageAux(String lang) {
    state = state.copyWith(languageAux: lang);
  }
}

class SettingsState {
  final int darkMode;
  final int darkModeAux;
  final bool isSoundActive;
  final bool isVibrationActive;
  final double transitionTime;
  final Axis sliderDirection;
  final TypeDisplay typeDisplay;
  final int selectedAxiosOption;
  final Color color;
  final bool isMainDisplayInPageView;
  final bool isTurned;
  final String language;
  final String languageAux;

  SettingsState({
    required this.darkMode,
    required this.isSoundActive,
    required this.isVibrationActive,
    required this.transitionTime,
    required this.sliderDirection,
    required this.selectedAxiosOption,
    required this.typeDisplay,
    required this.color,
    required this.isMainDisplayInPageView,
    required this.isTurned,
    required this.language,
    required this.darkModeAux,
    required this.languageAux,
  });

  SettingsState copyWith({
    int? darkMode,
    bool? isSoundActive,
    bool? isVibrationActive,
    double? transitionTime,
    Axis? sliderDirection,
    TypeDisplay? typeDisplay,
    int? selectedAxiosOption,
    Color? color,
    bool? isMainDisplayInPageView,
    bool? isTurned,
    String? language,
    int? darkModeAux,
    String? languageAux,
  }) {
    return SettingsState(
      darkMode: darkMode ?? this.darkMode,
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
      language: language ?? this.language,
      languageAux: languageAux ?? this.languageAux,
      darkModeAux: darkModeAux ?? this.darkModeAux,
    );
  }
}
