part of '../widgets/widgets.dart';

class SignIcon extends ConsumerWidget {
  final IconData icon;
  final double? size;

  SignIcon({super.key, required this.icon, this.size});
  @override
  Widget build(BuildContext context, ref) {
    final settingS = ref.watch(settingsProvider);
    final iconSign = Icon(
      icon,
      color: icon == spaceBarIcon ? Colors.transparent : settingS.color,
      size: size,
    );
    return settingS.isTurned
        ? Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(math.pi),
            child: iconSign,
          )
        : iconSign;
  }
}
