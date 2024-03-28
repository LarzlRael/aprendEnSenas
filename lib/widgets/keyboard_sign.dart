part of 'widgets.dart';

class KeyColor {
  String key;
  Color? color;
  KeyColor({
    required this.key,
    this.color,
  });

  KeyColor copyWith({
    String? key,
    Color? color,
  }) {
    return KeyColor(
      key: key ?? this.key,
      color: color ?? this.color,
    );
  }
}

class KeyboardSignWidget extends HookConsumerWidget {
  const KeyboardSignWidget({
    super.key,
    this.onChanged,
    this.onBackSpace,
    this.onLetterChanged,
    this.coloredKeys,
    this.showNumbers = true,
    this.showSpace = true,
    this.lettersUppercase = false,
    this.showSwitcherLetter = true,
    this.onEnter,
  });
  final Function(String value)? onChanged;
  final Function(String value)? onLetterChanged;
  final Function(String onChange)? onBackSpace;
  final Function()? onEnter;
  final List<KeyColor>? coloredKeys;
  final bool showNumbers;
  final bool showSpace;
  final bool lettersUppercase;
  final bool showSwitcherLetter;

  @override
  Widget build(BuildContext context, ref) {
    final text = useState<String>('');

    return KeyboardSign(
      onPressed: (String newText) {
        text.value = text.value + newText;
        onChanged!(text.value);
        onLetterChanged!(newText);
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
      coloredKeys: coloredKeys,
      showNumbers: showNumbers,
      showSpace: showSpace,
      lettersUppercase: lettersUppercase,
      onEnter: onEnter,
      showSwitcherLetter: showSwitcherLetter,
    );
  }
}

class KeyboardSign extends HookConsumerWidget {
  final bool showNumbers;
  final bool showSpace;
  final bool isShowIcons;
  final String text;
  final bool lettersUppercase;
  final bool showSwitcherLetter;
  final Function(String newText)? onPressed;
  final Function()? onLongPress;
  final Function()? onBackSpace;
  final Function()? onSpace;
  final Function()? onEnter;
  final List<KeyColor>? coloredKeys;
  const KeyboardSign({
    super.key,
    this.isShowIcons = true,
    this.text = '',
    this.onPressed,
    this.onLongPress,
    this.onBackSpace,
    this.onSpace,
    this.onEnter,
    this.showSwitcherLetter = true,
    this.coloredKeys,
    this.showNumbers = true,
    this.showSpace = true,
    this.lettersUppercase = false,
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
          showNumbers: showNumbers,
          showSpace: showSpace,
          showSwitcherLetter: showSwitcherLetter,
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
                  /* bgColor: Colors.blue, */
                  bgColor: coloredKeys != null && coloredKeys!.isNotEmpty
                      ? coloredKeys!
                          .firstWhere(
                            (element) => element.key == key.value.letter,
                            orElse: () => KeyColor(key: key.value.letter),
                          )
                          .color
                      : null,
                  keyView: key.type == KeyboardButtonType.normal
                      ? (showIcons.value
                          ? Icon(
                              key.value.iconSign,
                              size: 30,
                              color: Colors.white,
                            )
                          : Text(
                              lettersUppercase
                                  ? key.value.letter.toUpperCase()
                                  : key.value.letter,
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
                      case KeyboardButtonType.enter:
                        if (onEnter != null) onEnter!();
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
