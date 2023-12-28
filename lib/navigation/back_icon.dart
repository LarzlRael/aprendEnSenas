part of '../widgets/widgets.dart';

class BackIcon extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  final Function()? onPressed;
  final double? size;
  final Color? color;
  const BackIcon({
    super.key,
    this.margin,
    this.size,
    this.onPressed,
    this.color = Colors.green,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size ?? 45,
      height: size ?? 45,
      margin: margin,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: IconButton(
        onPressed: onPressed ?? () => context.pop(),
        icon: Icon(
          Icons.arrow_back_rounded,
          color: Colors.white,
        ),
      ),
    );
  }
}
