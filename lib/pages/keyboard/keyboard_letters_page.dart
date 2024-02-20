part of '../pages.dart';

class KeyboardLettersPage extends HookConsumerWidget {
  const KeyboardLettersPage({super.key});
  static const routeName = '/keyboard_letters_page';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signProviderS = ref.watch(signProvider).currentListSing;
    final currentSign = useState<Sign?>(null);

    void findLetter(String letter) {
      currentSign.value = signProviderS.firstWhere(
        (element) => element.letter == letter,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Keyboard'),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: ColoredIcon(
                icon: currentSign.value?.iconSign ?? Icons.access_alarm,
                size: 300,
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                ),
                itemCount: signProviderS.length,
                itemBuilder: (context, index) {
                  final letter = signProviderS[index];
                  return _Button(
                    letter: letter.letter,
                    onTap: findLetter,
                    isSelected: currentSign.value?.letter == letter.letter,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  final String letter;
  final Function(String letter) onTap;
  final bool isSelected;

  const _Button({
    required this.letter,
    required this.onTap,
    required this.isSelected,
  });
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      onTap: () => onTap(letter),
      child: Card(
        color: isSelected ? colorScheme.primary : null,
        child: Center(
          child: SimpleText(
            text: letter,
            style: textTheme.headlineSmall!.copyWith(
              color: isSelected ? Colors.white : null,
              fontWeight: FontWeight.w300,
            ),
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
