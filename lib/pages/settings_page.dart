part of 'pages.dart';

List<String> getThemesNames(BuildContext context) {
  return <String>[
    AppLocalizations.of(context)!.default_system,
    AppLocalizations.of(context)!.light,
    AppLocalizations.of(context)!.dark,
  ];
}

List<String> getHorinzontationNames(BuildContext context) {
  return <String>[
    AppLocalizations.of(context)!.horizontal,
    AppLocalizations.of(context)!.vertical,
    AppLocalizations.of(context)!.images,
  ];
}

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

    Future<void> openThemeDialog() async {
      await openDialogBuilder(
        context,
        AppLocalizations.of(context)!.choose_theme,
        Consumer(builder: (context, ref, child) {
          final settingS = ref.watch(settingsProvider);
          final settingN = ref.read(settingsProvider.notifier);
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: getThemesNames(context)
                .mapIndexed(
                  (index, e) => ListTile(
                      onTap: () {
                        settingN.toggleTheme(index);
                        context.pop();
                      },
                      leading: Radio(
                        value: index,
                        groupValue: settingS.darkMode,
                        onChanged: (value) {
                          settingN.toggleTheme(index);
                          context.pop();
                        },
                      ),
                      title: Text(e,
                          style: Theme.of(context).textTheme.bodySmall)),
                )
                .toList(),
          );
        }),
      );
    }

/* fix message when language is changed */
    Future<void> openLanguageDialog() async {
      String auxLanguage = "";
      await openDialogBuilder(
          context, AppLocalizations.of(context)!.choose_language,
          Consumer(builder: (context, ref, child) {
        final languageAux = ref.watch(settingsProvider).languageAux;
        final settingNotifier = ref.read(settingsProvider.notifier);

        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FlagButtonRow(
                pathImage: esFlag,
                language: AppLocalizations.of(context)!.spanish,
                isSelected: languageAux == 'es',
                onTap: () {
                  settingNotifier.setLanguageAux('es');
                  auxLanguage = 'es';
                },
              ),
              FlagButtonRow(
                pathImage: enFlag,
                language: AppLocalizations.of(context)!.english,
                isSelected: languageAux == 'en',
                onTap: () {
                  settingNotifier.setLanguageAux('en');
                  auxLanguage = 'en';
                },
              ),
            ],
          ),
        );
      }), actions: [
        Row(children: [
          Expanded(
            child: FilledButton(
              onPressed: () async {
                await settingN.changeLanguage(auxLanguage);
                context.pop();
              },
              child: Text(AppLocalizations.of(context)!.save),
            ),
          ),
        ]),
      ]);
    }

    Future<void> openHorientationDialog() async {
      await openDialogBuilder(
        context,
        AppLocalizations.of(context)!.choose_theme,
        Column(
          mainAxisSize: MainAxisSize.min,
          children: getHorinzontationNames(context)
              .mapIndexed(
                (index, e) => ListTile(
                    onTap: () {
                      settingN.setSelectedDisplayOption(index);
                      context.pop();
                    },
                    leading: Radio(
                      value: index,
                      groupValue:
                          ref.watch(settingsProvider).selectedAxiosOption,
                      onChanged: (value) {
                        settingN.setSelectedDisplayOption(index);
                        context.pop();
                      },
                    ),
                    title:
                        Text(e, style: Theme.of(context).textTheme.bodySmall)),
              )
              .toList(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: LetterAndSign(text: AppLocalizations.of(context)!.settings),
        leading: BackIcon(
          margin: EdgeInsets.only(left: 10),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              ListTile(
                leading: Icon(
                  Icons.brightness_4_sharp,
                ),
                subtitle: Text(
                  getThemesNames(context)[settingS.darkMode],
                  style: textTheme.bodySmall,
                ),
                title: Text(
                  AppLocalizations.of(context)!.theme,
                  style: textTheme.titleSmall,
                ),
                onTap: () async {
                  await openThemeDialog();
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.exit_to_app,
                  /* color: Theme.of(context).colorScheme.primary, */
                ),
                title: Text(
                  AppLocalizations.of(context)!.transition_type,
                  style: textTheme.titleSmall,
                ),
                subtitle: Text(
                  getHorinzontationNames(context)[settingS.selectedAxiosOption],
                  style: textTheme.bodySmall,
                ),
                onTap: () async {
                  await openHorientationDialog();
                },
              ),
              ListTile(
                leading: Icon(Icons.language),
                title: Text(
                  AppLocalizations.of(context)!.language,
                  style: textTheme.titleSmall,
                ),
                subtitle: Text(
                  settingS.language == 'es'
                      ? AppLocalizations.of(context)!.spanish
                      : AppLocalizations.of(context)!.english,
                  style: textTheme.bodySmall,
                ),
                onTap: () async {
                  await openLanguageDialog();
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OptionSetting(
                    title: AppLocalizations.of(context)!.vibration,
                    subTitle: settingS.isVibrationActive
                        ? AppLocalizations.of(context)!.on
                        : AppLocalizations.of(context)!.off,
                    value: settingS.isVibrationActive,
                    onTap: settingN.toggleVibration,
                  ),
                  OptionSetting(
                    title: AppLocalizations.of(context)!.sound,
                    subTitle: settingS.isSoundActive
                        ? AppLocalizations.of(context)!.on
                        : AppLocalizations.of(context)!.off,
                    value: settingS.isSoundActive,
                    onTap: settingN.toggleSound,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SimpleText(
                    text: AppLocalizations.of(context)!.transition_delay,
                    style: textTheme.titleSmall,
                  ),
                  Slider(
                    min: 250,
                    max: 2500,
                    divisions: 10,
                    label: settingS.transitionTime.toString(),
                    value: settingS.transitionTime,
                    onChanged: settingN.setTransitionTime,
                  ),
                  Text(
                      '${AppLocalizations.of(context)!.current_time}: ${settingS.transitionTime}'),
                  OptionSetting(
                    title: AppLocalizations.of(context)!.reverse_signals,
                    subTitle: settingS.isTurned
                        ? AppLocalizations.of(context)!.right
                        : AppLocalizations.of(context)!.left,
                    value: settingS.isTurned,
                    onTap: settingN.setIsTurned,
                  ),
                  SimpleText(
                    text: AppLocalizations.of(context)!.signaling_style,
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
                    text: AppLocalizations.of(context)!.icon_color,
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
  const CustomCheckBox({
    super.key,
    required this.onTap,
    required this.value,
    required this.label,
  });
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
          child: SignIcon(
            icon: icon,
            size: 70,
          ),
        ),
      ),
    );
  }
}
