part of '../pages.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});
  static const routeName = 'test_page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('TestPage'),
      ),
    );
  }
}
