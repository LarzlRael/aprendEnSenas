part of '../widgets/widgets.dart';


class FlagButton extends StatelessWidget {
  final String pathImage;
  final String language;
  final Function onTap;
  final bool isSelected;

  const FlagButton({
    super.key,
    required this.pathImage,
    required this.onTap,
    required this.language,
    required this.isSelected,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Card(
        /*  shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
            color: isSelected ? Colors.green : Colors.transparent,
            width: 10,
          ),
        ), */
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: isSelected ? Colors.green : Colors.transparent,
              width: 3.5,
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Column(
            children: [
              Image.asset(
                pathImage,
                width: 50,
                height: 50,
              ),
              Text(language),
            ],
          ),
        ),
      ),
    );
  }
}
