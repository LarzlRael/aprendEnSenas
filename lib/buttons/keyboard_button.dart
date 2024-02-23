part of '../widgets/widgets.dart';

class KeyboardButton extends StatelessWidget {
  final Color? bgColor;
  final KeyboardButtonType type;
  final IconData text;

  final Function()? onPressed;
  final Function()? onLongPress;
  final Widget? icon;
  KeyboardButton({
    Key? key,
    this.bgColor,
    this.icon,
    required this.type,
    required this.text,
    required this.onPressed,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    // Button
    final buttonStyle = TextButton.styleFrom(
      backgroundColor: this.bgColor,
      primary: Colors.white,
      shape: StadiumBorder(),
    );
    final mediaQuery = MediaQuery.of(context).size;
    return InkWell(
      onLongPress: onLongPress,
      onTap: onPressed,
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: this.bgColor,
          border: Border.all(color: Colors.grey, width: .5),
        ),
        child: Container(
          width: widthByType(type, mediaQuery),
          height: 40,
          child: Center(
            child: icon != null ? icon : Icon(text),
          ),
        ),
      ),
    );
  }

  double widthByType(KeyboardButtonType type, Size mediaQuery) {
    switch (type) {
      case KeyboardButtonType.normal:
        return mediaQuery.width * 0.08;

      case KeyboardButtonType.backSpace:
        return mediaQuery.width * 0.1;

      case KeyboardButtonType.space:
        return mediaQuery.width * 0.45;

      default:
        return mediaQuery.width * 0.08;
    }
  }
}
