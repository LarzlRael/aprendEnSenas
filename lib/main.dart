import 'package:asl/firebase_options.dart';
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

void main() async {
  await Enviroment.initEnviroment();
  await AdmobPlugin.initialize();
  await UserPreferences.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
    final notificationProvider = ref.watch(notificationNotifierProvider);

    return MaterialApp.router(
      title: appName,
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: AppTheme(isDarkmode: settingsProviderS.isDarkMode).getTheme(),
    );
  }
}
