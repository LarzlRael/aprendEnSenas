part of '../pages.dart';

class GameOverScreen extends HookWidget {
  final int duration;
  final Difficulty difficulty;
  const GameOverScreen({
    super.key,
    required this.difficulty,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    final _confettiController = useState<ConfettiController>(
        ConfettiController(duration: const Duration(seconds: 12)));

    useEffect(() {
      _confettiController.value.play();
      return () => _confettiController.dispose();
    }, const []);

    final theme = Theme.of(context).textTheme;
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "Under",
                    style: theme.bodyLarge,
                    children: [
                      TextSpan(
                        text: " ${duration} ",
                        style: theme.displaySmall,
                      ),
                      TextSpan(text: "Segundos", style: theme.bodySmall),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "Felicidades!",
                    style: theme.bodyLarge,
                    children: [
                      TextSpan(
                        text:
                            "You've successfully completed the Flutter memory game. Your sharp memory and quick thinking have helped you emerge victorious. Keep up the good work and keep challenging yourself as you learn Flutter and continue to improve your skills.",
                        style: theme.bodySmall,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    context.push(
                      '/games/flipping_cards_page',
                      extra: getNextDifficulty(difficulty),
                    );
                  },
                  child: const Text("Ve al siguiente nivel"),
                ),
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
    );
  }
}
