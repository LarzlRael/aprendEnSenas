part of '../widgets/widgets.dart';

class CheckboxLabel extends StatelessWidget {
  final String label;
  final bool value;
  final Function(bool value) onChanged;

  const CheckboxLabel({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(label),
        Switch(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
