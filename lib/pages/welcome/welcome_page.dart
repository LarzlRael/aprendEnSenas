part of '../pages.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});
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
