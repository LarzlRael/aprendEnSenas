import 'package:flutter_dotenv/flutter_dotenv.dart';

class Enviroment {
  static initEnviroment() async {
    await dotenv.load(
      fileName: '.env',
    );
  }

  static String googleMapsApiKey =
      dotenv.env['GOOGLE_MAPS_API_KEY'] ?? 'No está configurado el API_URL';

  static String adBannerId =
      dotenv.env['AD_BANNER_ID'] ?? "ca-app-pub-3940256099942544/6300978111";

  static String adIntersitialId = dotenv.env['AD_INTERSITIAL_ID'] ??
      "ca-app-pub-3940256099942544/1033173712";

  static String deepLinkUrl = dotenv.env['DEEP_LINK_URL'] ?? "";
}
