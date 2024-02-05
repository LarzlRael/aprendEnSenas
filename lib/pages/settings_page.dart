part of 'pages.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});
  static const routeName = '/settings_page';
  @override
  Widget build(BuildContext context, ref) {
    final settingS = ref.watch(settingsProvider);
    final settingN = ref.read(settingsProvider.notifier);
    final signProviderN = ref.read(signProvider.notifier);
    final signProviderS = ref.watch(signProvider);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: LetterAndSign(text: 'Ajustes'),
        leading: BackIcon(
          margin: EdgeInsets.only(left: 10),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OptionSetting(
                    title: 'Tema',
                    subTitle: 'Tema oscuro',
                    value: settingS.isDarkMode,
                    onTap: settingN.toggleDarkMode,
                  ),
                  OptionSetting(
                    title: 'Vibración',
                    subTitle: 'Activado',
                    value: settingS.isVibrationActive,
                    onTap: settingN.toggleVibration,
                  ),
                ],
              ),
              OptionSetting(
                title: 'Sonido',
                subTitle: 'Activado',
                value: settingS.isSoundActive,
                onTap: settingN.toggleSound,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SimpleText(
                    text: 'Tiempo de retraso de transición',
                    style: textTheme.titleSmall,
                  ),
                  Slider(
                    min: 250,
                    max: 2500,
                    divisions: 10,
                    label: settingS.transitionTime.toString(),
                    value: settingS.transitionTime,
                    onChanged: (value) => settingN.setTransitionTime(value),
                  ),
                  Text('Tiempo actual: ${settingS.transitionTime}'),
                  SimpleText(
                    text: 'Tipo de transición',
                    style: textTheme.titleSmall,
                  ),
                  CustomCheckBox(
                    label: 'Horizontal',
                    value: settingS.selectedAxiosOption == 0,
                    onTap: () => settingN.setSelectedDisplayOption(0),
                  ),
                  CustomCheckBox(
                    label: 'Vertical',
                    value: settingS.selectedAxiosOption == 1,
                    onTap: () => settingN.setSelectedDisplayOption(1),
                  ),
                  CustomCheckBox(
                    label: 'Imagenes',
                    value: settingS.selectedAxiosOption == 2,
                    onTap: () => settingN.setSelectedDisplayOption(2),
                  ),
                  SimpleText(
                    text: 'Estilo de señalización',
                    style: textTheme.titleSmall,
                    padding: EdgeInsets.symmetric(vertical: 5),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      children: signListProvider
                          .mapIndexed(
                            (index, sign) => IconShowToChange(
                              icon: sign[0].iconSign,
                              onTap: () =>
                                  signProviderN.changeListSignIndex(index),
                              isSelect: signProviderS.currentListIndex == index,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  SimpleText(
                    text: 'Color de icono',
                    style: textTheme.titleSmall,
                    padding: EdgeInsets.symmetric(vertical: 5),
                  ),
                  MaterialColorPicker(
                    onColorChange: settingN.setIconColor,
                    selectedColor: settingS.color,
                  )
                ],
              )
            ],
          ),
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

class IconShowToChange extends StatelessWidget {
  final IconData icon;
  final Function() onTap;
  final bool isSelect;
  const IconShowToChange({
    super.key,
    required this.icon,
    required this.onTap,
    required this.isSelect,
  });
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return InkWell(
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color:
                isSelect ? colors.primary.withOpacity(0.8) : Colors.transparent,
            width: 2,
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          child: ColoredIcon(
            icon: icon,
            size: 70,
          ),
        ),
      ),
    );
  }
}
