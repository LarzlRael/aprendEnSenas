import 'package:asl/firebase_options.dart';
import 'package:asl/l10n/l10n.dart';
import 'package:asl/plugin/admob_plugin.dart';
import 'package:asl/provider/notification_provider.dart';
import 'package:asl/provider/settings_provider.dart';
import 'package:asl/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:asl/router/app_router.dart';
import 'package:asl/utils/utils.dart';
import 'constants/constant.dart';
import 'constants/enviroments.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  await Enviroment.initEnviroment();
  await AdmobPlugin.initialize();
  await UserPreferences.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  /* await FirebaseUtils().initializeRemoteConfig(); */
  return runApp(
    ProviderScope(
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final settingsProviderS = ref.watch(settingsProvider);
    final settingsProviderN = ref.read(settingsProvider.notifier);
    final notificationProvider = ref.watch(notificationNotifierProvider);

    return MaterialApp.router(
      title: appName,
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: AppTheme(isDarkmode: settingsProviderN.isDarkModeEnabled())
          .getTheme(),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: Locale(settingsProviderS.language),
      supportedLocales: L10n.all,
    );
  }
}
