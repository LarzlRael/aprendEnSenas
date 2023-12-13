part of 'pages.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final list = signList;
    return Scaffold(
      body: ListView.builder(
        itemCount: signList.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              child: ColorFilteredSvg(
            pathImage: list[index].pathImage,
          ));
        },
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
