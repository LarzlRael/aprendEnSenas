part of '../widgets/widgets.dart';

class BackIcon extends StatelessWidget {
  final EdgeInsetsGeometry? margin;

  const BackIcon({super.key, this.margin});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45,
      height: 45,
      margin: margin,
      decoration: const BoxDecoration(
        color: Colors.green,
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
        onPressed: context.pop,
        icon: Icon(
          Icons.arrow_back_rounded,
          color: Colors.white,
        ),
      ),
    );
  }
}
