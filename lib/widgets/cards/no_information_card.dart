part of '../widgets.dart';

class NoInformationCard extends StatelessWidget {
  final String title;
  final String description;
  final EdgeInsets? padding;

  const NoInformationCard({
    super.key,
    required this.title,
    required this.description,
    this.padding,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: padding ?? const EdgeInsets.all(10),
        child: Column(
          children: [
            SimpleText(
              text: title,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
            SimpleText(
              padding: const EdgeInsets.only(top: 5),
              text: description,
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ],
        ),
      ),
    );
  }
}
