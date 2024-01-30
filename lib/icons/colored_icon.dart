part of '../widgets/widgets.dart';

class CustomIcon extends Icon {
  // Puedes agregar tus propios atributos aquí
  final Color customColor;

  // Constructor que llama al constructor de la clase base (Icon)
  CustomIcon(IconData icon, {Key? key, this.customColor = Colors.black})
      : super(icon, key: key);
}

class ColoredIcon extends ConsumerWidget {
  final IconData icon;
  final double? size;
  const ColoredIcon({
    Key? key,
    required this.icon,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final settings = ref.watch(settingsProvider);

    return Icon(
      icon,
      color: settings.color,
      size: size,
    );
  }
}
