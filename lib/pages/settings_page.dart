part of 'pages.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context, ref) {
    final settings = ref.watch(settingsProviderProvider);
    final reff = ref.read(settingsProviderProvider.notifier);
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
                TextButton(
                  onPressed: () {
                    reff.setSelectedAxiosOption(0);
                    reff.setSliderDirection(Axis.horizontal);
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
                                reff.setSelectedAxiosOption(0);
                                reff.setSliderDirection(Axis.horizontal);
                              })),
                      SizedBox(width: 10.0),
                      Text("Horizontal")
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    reff.setSelectedAxiosOption(1);
                    reff.setSliderDirection(Axis.vertical);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: 24.0,
                          width: 24.0,
                          child: Checkbox(
                              value: settings.selectedAxiosOption == 1,
                              onChanged: (value) {
                                reff.setSelectedAxiosOption(1);
                                reff.setSliderDirection(Axis.vertical);
                              })),
                      SizedBox(width: 10.0),
                      Text("Vertical")
                    ],
                  ),
                ),
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
