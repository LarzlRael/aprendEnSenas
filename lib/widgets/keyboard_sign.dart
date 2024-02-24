part of 'widgets.dart';

class KeyboardSignWidget extends HookConsumerWidget {
  const KeyboardSignWidget({super.key, this.onChanged, this.onBackSpace});
  final Function(String value)? onChanged;
  final Function(String onChange)? onBackSpace;

  @override
  Widget build(BuildContext context, ref) {
    final text = useState<String>('');

    return KeyboardSign(
      onPressed: (String newText) {
        text.value = text.value + newText;
        onChanged!(text.value);
      },
      onLongPress: () {
        text.value = '';
      },
      onBackSpace: () {
        if (text.value.isNotEmpty)
          text.value = text.value.substring(0, text.value.length - 1);
        onBackSpace!(text.value);
      },
      onSpace: () {
        text.value = text.value + ' ';
      },
    );
  }
}

class KeyboardSign extends HookConsumerWidget {
  final bool isShowIcons;
  final String text;
  final Function(String newText)? onPressed;
  final Function()? onLongPress;
  final Function()? onBackSpace;
  final Function()? onSpace;
  const KeyboardSign({
    super.key,
    this.isShowIcons = true,
    this.text = '',
    this.onPressed,
    this.onLongPress,
    this.onBackSpace,
    this.onSpace,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showIcons = useState<bool>(isShowIcons);
    final textState = useState<String>(text);
    return Column(
      /* mainAxisAlignment: MainAxisAlignment.end, */

      children: [
        for (var row in keyboardListGenerate(
          ref.read(signProvider).currentListSing,
          changeView: true,
        ))
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Create a button for each key in the row
              for (var key in row)
                KeyboardButton(
                  /* isSelected: textGame.value
                      .map((e) => e.letter)
                      .join()
                      .contains(key.value.letter), */
                  keyView: key.type == KeyboardButtonType.normal
                      ? (showIcons.value
                          ? Icon(
                              key.value.iconSign,
                              size: 30,
                              color: Colors.white,
                            )
                          : Text(
                              key.value.letter,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ))
                      : key.widgetIcon,
                  icon: key.widgetIcon,
                  type: key.type!,
                  onLongPress: onLongPress,
                  onPressed: () {
                    switch (key.type) {
                      case KeyboardButtonType.backSpace:
                        onBackSpace!();
                        break;
                      case KeyboardButtonType.normal:
                        textState.value = key.value.letter;
                        onPressed!(textState.value);
                        break;

                      case KeyboardButtonType.space:
                        onSpace!();
                        break;
                      case KeyboardButtonType.changeView:
                        showIcons.value = !showIcons.value;
                        break;
                      default:
                    }
                  },
                ),
            ],
          ),
      ],
    );
  }
}
