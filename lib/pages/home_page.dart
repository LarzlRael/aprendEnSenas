part of 'pages.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final list = signLowerLetters;
    return Scaffold(
      body: Container(
        child: Image.asset(
          'assets/signs_png/0_number.png',
          /* color: Colors.white, */
          /* colorBlendMode: BlendMode.xor, */
        ),
      ),
    );
  }
}

class ColorFilteredSvg extends StatelessWidget {
  final String pathImage;

  const ColorFilteredSvg({super.key, required this.pathImage});
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      pathImage, // Reemplaza con la ruta de tu archivo SVG
      height: 200,
      width: 200,
    ); //) Cambia el color de tu SVG
  }
}
