part of '../pages.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});
  static const routeName = '/welcome_page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Slideshow(
          slides: [
            Text('qie feu'),
          ],
          primaryColor: Colors.red,
          secondaryColor: Colors.grey,
        ),
      ),
    );
  }
}
