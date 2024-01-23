part of '../widgets/widgets.dart';

const borderRadious = 40.0;

class TextFieldSendMessage extends HookConsumerWidget {
  TextFieldSendMessage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController()
      ..value = TextEditingValue(
          text: ref.watch(signProviderProvider).currentMessage);

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
                      textController.text = "";
                      textController.clear();

                      /* ref.read(brailleProvider.notifier).setNormalText(""); */
                    },
                    icon: Icon(
                      Icons.cancel,
                    ),
                  )
                : null,
          ),
          onChanged: (val) {
            ref
                .read(
                  signProviderProvider.notifier,
                )
                .setCurrentMessage(val);
            /* onTextChange(value); */
          },
        ),
      ),
    );
  }
}
