part of '../pages.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});
  static const routeName = '/splash_screen_page';
  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  void _checkFirstTime() async {
    final isFirstTime = await KeyValueStorageServiceImpl().getValue<bool>(
          IS_FIRST_TIME_KEY,
        ) ??
        true;

    if (isFirstTime) {
      // Primera vez que se inicia la aplicación
      context.go(WelcomePage.routeName);
      // Actualizamos el valor en SharedPreferences para indicar que ya se mostró la vista "Welcome".
    } else {
      // No es la primera vez que se inicia la aplicación
      context.go(HomePage.routeName);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkFirstTime();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
