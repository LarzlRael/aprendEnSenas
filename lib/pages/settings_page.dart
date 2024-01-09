part of 'pages.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context, ref) {
    final settings = ref.watch(settingsProvider);
    final reff = ref.read(settingsProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Ajustes"),
        leading: BackIcon(
          margin: EdgeInsets.only(left: 10),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OptionSetting(
                  title: 'Tema',
                  subTitle: 'Thme oscuro',
                  value: settings.isDarkMode,
                  onTap: () {
                    reff.toggleDarkMode();
                  },
                ),
                OptionSetting(
                    title: 'Vibracion',
                    subTitle: 'Activado',
                    value: settings.isVibrationActive,
                    onTap: () {
                      reff.toggleVibration();
                    }),
              ],
            ),
            OptionSetting(
              title: 'Sonido',
              subTitle: 'Activado',
              value: settings.isSoundActive,
              onTap: () {
                reff.toggleSound();
              },
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tiempo de retraso de transicion'),
                Slider(
                    divisions: 10,
                    label: settings.transitionTime.toString(),
                    value: settings.transitionTime,
                    onChanged: (value) {
                      reff.setTransitionTime(value);
                    }),
                Text('Tiempo actual: ${settings.transitionTime}'),
                Text('Transicion'),
                /* TextButton(
                  onPressed: () {
                    reff.setSelectedDisplayOption(0);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: 24.0,
                          width: 24.0,
                          child: Checkbox(
                              value: settings.selectedAxiosOption == 0,
                              onChanged: (value) {
                                reff.setSelectedDisplayOption(0);
                              })),
                      SizedBox(width: 10.0),
                      Text("Horizontal")
                    ],
                  ),
                ), */
                CustomCheckBox(
                  label: 'Horizontal',
                  value: settings.selectedAxiosOption == 0,
                  onTap: () {
                    reff.setSelectedDisplayOption(0);
                  },
                ),
                CustomCheckBox(
                  label: 'Vertical',
                  value: settings.selectedAxiosOption == 1,
                  onTap: () {
                    reff.setSelectedDisplayOption(1);
                  },
                ),
                CustomCheckBox(
                  label: 'Imagenes',
                  value: settings.selectedAxiosOption == 2,
                  onTap: () {
                    reff.setSelectedDisplayOption(2);
                  },
                ),
                SimpleText(
                  text: 'Color de fondo',
                  style: Theme.of(context).textTheme.titleSmall,
                  padding: EdgeInsets.symmetric(vertical: 5),
                ),
                MaterialColorPicker(
                  onColorChange: (Color color) {
                    // Handle color changes
                    reff.setIconColor(color);
                  },
                  selectedColor: settings.color,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class OptionSetting extends StatelessWidget {
  final String title;
  final String subTitle;
  final Function onTap;
  final bool value;

  const OptionSetting({
    super.key,
    required this.title,
    required this.onTap,
    required this.subTitle,
    required this.value,
  });
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SimpleText(
          text: title,
          style: textTheme.titleSmall,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              subTitle,
              style: textTheme.bodySmall,
            ),
            Switch(
              value: value,
              onChanged: (value) {
                onTap();
              },
            ),
          ],
        ),
      ],
    );
  }
}

class CustomCheckBox extends ConsumerWidget {
  const CustomCheckBox(
      {super.key,
      required this.onTap,
      required this.value,
      required this.label});
  final Function() onTap;
  final bool value;
  final String label;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
              height: 24.0,
              width: 24.0,
              child: Checkbox(value: value, onChanged: (value) => onTap())),
          SizedBox(width: 10.0),
          Text(label),
        ],
      ),
    );
  }
}
