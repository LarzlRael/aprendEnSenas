part of '../services.dart';

abstract class VibrateService {
  Future<void> vibrate({int? millisec});
}
