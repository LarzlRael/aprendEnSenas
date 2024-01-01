part of 'utils.dart';

class UserPreferences {
  //no one this properties it is used
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }
}
