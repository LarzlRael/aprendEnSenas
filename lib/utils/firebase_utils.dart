part of 'utils.dart';

class FirebaseUtils {
  static final FirebaseRemoteConfig remoteConfig =
      FirebaseRemoteConfig.instance;

  Future<void> initializeRemoteConfig() async {
    await remoteConfig.setDefaults(<String, dynamic>{
      'deep_link_url': Enviroment.deepLinkUrl + "projectFile",
      'error': "this is by default value",
    });
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(hours: 1),
      ),
    );
    await remoteConfig.fetchAndActivate();
    print('deep_link_url: ${remoteConfig.getString('deep_link_url')}');
    print('deep_link_url: ${remoteConfig.getString('error')}');
  }
}
