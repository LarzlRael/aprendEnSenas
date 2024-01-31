part of '../pages.dart';

class SelectLevelPage extends HookWidget {
  final String gameTitle;
  final String? gameRouteDestinyPage;
  final IconData? iconGame;
  const SelectLevelPage({
    super.key,
    this.gameRouteDestinyPage,
    this.iconGame,
    required this.gameTitle,
  });

  @override
  Widget build(BuildContext context) {
    final _movieCardPageController = usePageController(viewportFraction: .77);
    final size = MediaQuery.of(context).size;
    final _movieCardPage = useState<double>(0.0);
    final _movieCardIndex = useState<int>(0);

    _movieCardPagePercentListener() {
      _movieCardPage.value = _movieCardPageController.page!;
    }

    useEffect(() {
      _movieCardPageController.addListener(() {
        _movieCardPage.value = _movieCardPageController.page!;
      });
      return () {
        _movieCardPageController.removeListener(_movieCardPagePercentListener);
      };
    }, []);
    return Scaffold(
        body: SizedBox.expand(
            child: Stack(children: [
      Positioned(
        left: 0,
        top: kToolbarHeight,
        child: BackIcon(
          margin: EdgeInsets.all(10),
        ),
      ),
      Positioned(
        right: 10,
        top: 10,
        child: FadeIn(
          duration: Duration(milliseconds: 1000),
          child: Icon(
            iconGame,
            size: 175,
            color: Colors.grey.withOpacity(0.3),
          ),
        ),
      ),
      Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SimpleText(
              text: gameTitle.snakeCaseToWords().toCapitalize(),
              fontSize: 25,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.center,
              lineHeight: 1,
            ),
            SimpleText(
              text: "Selecciona el nivel de dificultad",
              fontSize: 16,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.center,
              padding: EdgeInsets.symmetric(vertical: 15),
            ),
            SizedBox(
              height: size.height * 0.45,
              child: Swiper(
                loop: false,
                viewportFraction: 0.65,
                itemCount: Level.values.length,
                itemBuilder: (context, index) {
                  final level = Level.values[index];
                  return CardLevel(
                    level: level,
                    onTap: (Level level) {
                      context.push(
                        '/games/$gameRouteDestinyPage',
                        extra: level,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ])));
  }
}

class CardLevel extends StatelessWidget {
  final Level level;
  final Function(Level selectedLevel) onTap;

  const CardLevel({
    super.key,
    required this.level,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      onTap: () => onTap(level),
      child: Card(
          color: colorByLevel[level],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SimpleText(
                text: level.name.toUpperCase(),
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: Icon(
                  iconByLevel[level],
                  size: 75,
                  color: Colors.white,
                ),
              ),
              LetterAndSign(
                text: level.name.removeDiacriticsFromString(),
              )
            ],
          )),
    );
  }
}
