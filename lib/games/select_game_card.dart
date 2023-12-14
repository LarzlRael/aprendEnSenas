part of '../widgets/widgets.dart';

class SelectGameCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  final Function(BuildContext context)? onSelected;

  const SelectGameCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onSelected,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onSelected != null) {
          onSelected!(context);
        }
      },
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Card(
        child: Container(
          padding: EdgeInsets.all(5),
          width: 200,
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 75,
              ),
              SimpleText(
                text: title.snakeCaseToWords().toCapitalize(),
                fontSize: 15,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 5),
              SimpleText(
                text: subtitle,
                fontSize: 13,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
