part of '../pages.dart';

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final String subtitle;

  const MenuItem({
    super.key,
    required this.icon,
    required this.text,
    required this.subtitle,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(color: Colors.blue),
      child: Column(
        children: [
          Icon(Icons.ac_unit),
          /* SimpleText(text: "Test your game"),
          SimpleText(text: "Description"), */
          SimpleText(
            text: "Test your game",
            fontSize: 16,
            fontWeight: FontWeight.w700,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 5),
          SimpleText(
            text: "Test your game",
            fontSize: 14,
            fontWeight: FontWeight.w500,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
