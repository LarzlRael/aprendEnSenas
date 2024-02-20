part of '../pages.dart';

class GameOverScreen extends HookConsumerWidget {
  final Widget title;
  final Widget subtitle;
  final String? titleButton;
  final Function()? action;
  final ResultGameType resultType;
  final String pathImage;

  const GameOverScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.resultType,
    required this.pathImage,
    this.titleButton,
    this.action,
  });

  @override
  Widget build(BuildContext context, ref) {
    final pathImageState = useState<String>("");
    final _confettiController = useState<ConfettiController>(
        ConfettiController(duration: const Duration(seconds: 12)));
    void playSound() => ref.read(settingsProvider.notifier).playSound(
        resultType == ResultGameType.win
            ? getValueSoundFromList(winSoundsList)
            : getValueSoundFromList(loseSoundsList));

    useEffect(() {
      pathImageState.value = pathImage;
    }, const []);
    useEffect(() {
      if (resultType == ResultGameType.win) {
        _confettiController.value.play();
      }
      playSound();
      return () => _confettiController.dispose();
    }, const []);

    final theme = Theme.of(context).textTheme;
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  title,
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                    child: Image.asset(
                      pathImageState.value,
                      fit: BoxFit.cover,
                      height: 150,
                    ),
                  ),
                  subtitle,
                  /* const SizedBox(height: 20), */
                  action != null
                      ? ElevatedButton(
                          onPressed: action,
                          child: Text(titleButton ?? "Volver a jugar"),
                        )
                      : SizedBox(),
                ],
              ),
            ),
            if (resultType == ResultGameType.win)
              ConfettiWidget(
                numberOfParticles: 30,
                minBlastForce: 10,
                maxBlastForce: 20,
                blastDirectionality: BlastDirectionality.explosive,
                confettiController: _confettiController.value,
                gravity: 0.1,
              ),
          ],
        ),
      ),
    );
  }
}
