import 'package:flutter/material.dart';

class AppTheme {
  final bool isDarkmode;

  AppTheme({required this.isDarkmode});

  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
        brightness: isDarkmode ? Brightness.dark : Brightness.light,
        listTileTheme: const ListTileThemeData(
          iconColor: Colors.green,
        ),
      );
}
