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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: appName,
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}
