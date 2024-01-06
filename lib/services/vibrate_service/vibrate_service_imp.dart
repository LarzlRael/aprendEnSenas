part of '../services.dart';

class VibrateServiceImp implements VibrateService {
  @override
  Future<void> vibrate({int? millisec}) async {
    /* return _hasVibrator!
        ? Vibration.vibrate(
            duration: millisec ?? 1000,
          )
        : Future.value(); */
    if (await Vibration.hasVibrator() != null ||
        await Vibration.hasVibrator() == true) {
      Vibration.vibrate(
        duration: millisec ?? 500,
      );
    }
  }
}
