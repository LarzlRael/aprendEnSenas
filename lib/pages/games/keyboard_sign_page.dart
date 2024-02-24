part of '../pages.dart';

class KeyboardSignPage extends HookConsumerWidget {
  const KeyboardSignPage({super.key});
  static const routeName = 'keyboard_sign_page';
  @override
  Widget build(BuildContext context, ref) {
    final text = useState<String>('');
    final textSign = useState<List<Sign>>([]);
    final isLetter = useState<bool>(true);
    useEffect(() {
      return () {
        final list = generateListToMessageUtil(
          ref.read(signProvider).currentListSing,
          text.value,
        );
        textSign.value = List<Sign>.from(list);
      };
    }, [text.value]);
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          children: [
            SizedBox(height: 50),
            TextButton(
              onPressed: () {
                isLetter.value = !isLetter.value;
              },
              child: Text('cambiar vista'),
            ),
            Expanded(
              child: AlignedGridView.count(
                crossAxisCount: 5,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                itemCount: textSign.value.length,
                itemBuilder: (_, index) {
                  final e = textSign.value[index];
                  return Card(
                    child: Container(
                      width: 50,
                      height: 50,
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 5,
                      ),
                      child: Center(
                        child: isLetter.value
                            ? Text(
                                e.letter.toUpperCase(),
                                style: TextStyle(fontSize: 25),
                              )
                            : Icon(
                                e.iconSign,
                                size: 30,
                              ),
                      ),
                    ),
                  );
                },
              ),
            ),
            KeyboardSignWidget(
              onChanged: (String newText) {
                text.value = newText;
                print(newText);
              },
              onBackSpace: (newText) {
                text.value = newText;
                print(newText);
              },
              /* isShowIcons: !isLetter.value, */
            ),
          ],
        ),
      ),
    );
  }
}
