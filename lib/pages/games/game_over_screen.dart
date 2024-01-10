part of '../pages.dart';

class GameOverScreen extends HookConsumerWidget {
  final Level level;
  final Widget title;
  final Widget subtitle;
  final String? titleButton;
  final Function()? action;

  const GameOverScreen({
    super.key,
    required this.level,
    required this.title,
    required this.subtitle,
    this.titleButton,
    this.action,
  });

  @override
  Widget build(BuildContext context, ref) {
    final _confettiController = useState<ConfettiController>(
        ConfettiController(duration: const Duration(seconds: 12)));
    ref
        .watch(settingsProvider.notifier)
        .playSound("assets/sounds/win_sound.wav");
    useEffect(() {
      _confettiController.value.play();
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
                  subtitle,
                  const SizedBox(
                    height: 20,
                  ),
                  action != null
                      ? ElevatedButton(
                          onPressed: action,
                          child: Text(titleButton ?? "Volver a jugar"),
                        )
                      : SizedBox(),
                ],
              ),
            ),
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
