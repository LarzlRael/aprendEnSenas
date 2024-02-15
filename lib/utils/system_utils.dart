part of 'utils.dart';

String getSystemLanguage() => Platform.localeName.substring(0, 2);

Brightness getSystemApparience() {
  if (Platform.isIOS) {
    return SchedulerBinding.instance!.window.platformBrightness;
  } else {
    return SchedulerBinding.instance.platformDispatcher.platformBrightness;
  }
}
