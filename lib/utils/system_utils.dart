part of 'utils.dart';

String getSystemLanguage() => Platform.localeName.substring(0, 2);

Brightness getSystemApparience() {
  if (Platform.isIOS) {
    return SchedulerBinding.instance!.window.platformBrightness;
  } else {
    return SchedulerBinding.instance.platformDispatcher.platformBrightness;
  }
}

Future<void> openDialogBuilder(
    BuildContext context, String title, Widget content,
    {List<Widget>? actions}) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title,
            style:
                Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 16)),
        content: content,
        actions: actions ??
            <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Cancelar'),
                onPressed: context.pop,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Ok'),
                onPressed: context.pop,
              ),
            ],
      );
    },
  );
}
