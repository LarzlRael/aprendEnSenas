part of '../widgets/widgets.dart';

const borderRadious = 40.0;

class TextFieldSendMessage extends HookWidget {
  final Function(TextEditingController controller)? onClear;
  final String? initialValue;
  final Function(String value) onTextChange;
  TextFieldSendMessage({
    super.key,
    this.onClear,
    this.initialValue,
    required this.onTextChange,
  });
  @override
  Widget build(BuildContext context) {
    final textController = useTextEditingController()
      ..value = TextEditingValue(
        text: initialValue ?? "",
      );

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextField(
          /* focusNode: focusNode,
                 */
          controller: textController,
          minLines: 1,
          maxLines: 3,
          /*  style: textTheme.bodySmall!.copyWith(
                  fontSize: fontSize,
                  /* color: braileProvider.getPickerTextColor, */
                  /* color: globalProviderS.pickerColor, */
                  fontWeight: FontWeight.normal,
                ), */

          decoration: InputDecoration(
            /* hintText: "Ingrese su texto aquí", */
            /* contentPadding: EdgeInsets.symmetric(horizontal: 6), */
            hintStyle: TextStyle(fontSize: 15),
            border: InputBorder.none,
            suffixIcon: textController.text.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      if (onClear != null) {
                        onClear!(textController);
                      }
                    },
                    icon: Icon(
                      Icons.cancel,
                    ),
                  )
                : null,
          ),
          onChanged: (val) {
            /*  ref
                .read(
                  signProviderProvider.notifier,
                )
                .setCurrentMessage(val); */
            onTextChange(val);
          },
        ),
      ),
    );
  }
}
