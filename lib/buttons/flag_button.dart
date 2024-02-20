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

class FlagButtonRow extends StatelessWidget {
  final String pathImage;
  final String language;
  final Function onTap;
  final bool isSelected;

  const FlagButtonRow({
    super.key,
    required this.pathImage,
    required this.onTap,
    required this.language,
    required this.isSelected,
  });
  @override
  Widget build(BuildContext context) {
    final colorPrimary = Theme.of(context).colorScheme.primary;
    final borderRadius = 25.0;
    return InkWell(
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      onTap: () {
        onTap();
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            /* color: isSelected ? Colors.green : null, */
            border: Border.all(
              color: isSelected ? colorPrimary : Colors.transparent,
              width: 1.5,
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(500),
                child: Image.asset(
                  pathImage,
                  width: 30,
                  height: 30,
                ),
              ),
              SizedBox(width: 15),
              Text(language,
                  style: TextStyle(
                    color: isSelected ? Colors.white : null,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
