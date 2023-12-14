part of '../pages.dart';

class GuessTheWordPage extends HookWidget {
  const GuessTheWordPage({super.key});
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    final randomCommonWord = useState(getRandomWordFromStringList(commonWords));
    final currentWord = useState("");
    final isCorrect = useState(false);
    final onEditing = useState(true);

    useEffect(() {
      if (isCorrect.value) {
        randomCommonWord.value = getRandomWordFromStringList(commonWords);
        currentWord.value = "";
      }
      isCorrect.value = false;
    }, [isCorrect.value]);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                randomCommonWord.value,
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: mediaQuery.width * 0.8,
                height: mediaQuery.height * 0.60,
                color: Colors.black,
              ),
              SizedBox(
                height: 50,
                child: FilledButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.refresh),
                  label: Text('Reiniciar'),
                ),
              ),
              VerificationCode(
                fullBorder: true,
                itemSize: 55,
                underlineWidth: 1.5,
                /* textStyle: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: Theme.of(context).primaryColor), */
                textStyle: textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
                keyboardType: TextInputType.text,
                underlineColor: Colors
                    .amber, // If this is null it will use primaryColor: Colors.red from Theme
                length: randomCommonWord.value.length,
                cursorColor: Colors
                    .blue, // If this is null it will default to the ambient
                // clearAll is NOT required, you can delete it
                // takes any widget, so you can implement your design
                /* clearAll: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Limpiar',
                    style: TextStyle(
                        fontSize: 14.0,
                        /* decoration: TextDecoration.underline, */
                        color: Colors.blue[700]),
                  ),
                ), */
                margin: const EdgeInsets.all(5),
                onCompleted: (String value) {
                  currentWord.value = value;
                  if (currentWord.value == randomCommonWord.value) {
                    isCorrect.value = true;
                  }
                },

                onEditing: (bool value) {
                  onEditing.value = value;

                  if (!onEditing.value) FocusScope.of(context).unfocus();
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: onEditing.value
                      ? const Text('Please enter full code')
                      : Text('Your code: ${currentWord.value}'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
