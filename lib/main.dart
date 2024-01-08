import 'package:asl/provider/settings_provider.dart';
import 'package:asl/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:asl/router/app_router.dart';
import 'package:asl/utils/utils.dart';
import 'constants/constant.dart';
import 'constants/enviroments.dart';

void main() async {
  await Enviroment.initEnviroment();
  await UserPreferences.init();
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
    return MaterialApp.router(
      title: appName,
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: AppTheme(isDarkmode: settingsProviderS.isDarkMode).getTheme(),
    );
  }
}
