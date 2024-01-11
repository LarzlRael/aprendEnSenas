part of '../widgets/widgets.dart';

const borderRadious = 20.0;

class TextFieldSendMessage extends HookConsumerWidget {
  TextFieldSendMessage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController()
      ..value = TextEditingValue(
          text: ref.watch(signProviderProvider).currentMessage);

    return SizedBox(
      /* height: 45, */
      child: TextField(
        /* style: TextStyle(fontSize: 14.0, height: 1.0, color: Colors.black), */
        minLines: 1,
        maxLines: 2,
        controller: controller,
        decoration: InputDecoration(
          /* isDense: true, // Added this */
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          suffix: AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity:
                ref.watch(signProviderProvider).currentMessage.isEmpty ? 0 : 1,
            child: IconButton(
              color: Colors.grey,
              onPressed: () {
                controller.clear();
                ref.read(signProviderProvider.notifier).setCurrentMessage("");
              },
              icon: Icon(Icons.cancel),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadious),
            borderSide: BorderSide(
              color: Colors.orange,
            ),
          ),
          /* filled: true,
                        fillColor: Colors.black, */
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadious),
          ),
          /* hintText: "Escribe tu mensaje",
          hintStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ), */
          labelText: "Escribe tu mensaje",
        ),
        onChanged: (val) {
          ref
              .read(
                signProviderProvider.notifier,
              )
              .setCurrentMessage(val);
        },
      ),
    );
  }
}
