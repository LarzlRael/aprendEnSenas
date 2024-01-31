part of '../services.dart';

class VibrateServiceImp implements VibrateService {
  @override
  Future<void> vibrate({int? millisec}) async {
    if (await Vibration.hasVibrator() != null ||
        await Vibration.hasVibrator() == true) {
      Vibration.vibrate(
        duration: millisec ?? 150,
      );
    }
  }
}
