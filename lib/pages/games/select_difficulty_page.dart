part of '../pages.dart';

class SelectDifficultyPage extends HookWidget {
  final String gameTitle;
  final String? gameRouteDestinyPage;
  final IconData? iconGame;
  const SelectDifficultyPage({
    super.key,
    this.gameRouteDestinyPage,
    this.iconGame,
    required this.gameTitle,
  });

  @override
  Widget build(BuildContext context) {
    final _movieCardPageController = usePageController(viewportFraction: .77);

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
    return Scaffold(body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final h = constraints.maxHeight;
      final w = constraints.maxWidth;
      return Stack(children: [
        SafeArea(
          child: Positioned(
            left: 0,
            top: 0,
            child: BackIcon(
              margin: EdgeInsets.all(10),
            ),
          ),
        ),
        Positioned(
          right: 10,
          top: 10,
          child: Icon(
            iconGame,
            size: 175,
            color: Colors.grey.withOpacity(0.3),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                text: "Selecciona una dificultad",
                fontSize: 16,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.center,
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
              SizedBox(
                height: h * 0.6,
                child: PageView.builder(
                  controller: _movieCardPageController,
                  clipBehavior: Clip.none,
                  itemCount: Difficulty.values.length,
                  onPageChanged: (page) {
                    /* _movieDetailPageController.animateToPage(
                    page,
                    duration: const Duration(milliseconds: 1500),
                    curve: const Interval(0.25, 1, curve: Curves.decelerate),
                  ); */
                  },
                  itemBuilder: (_, index) {
                    final movie = Difficulty.values[index];
                    final progress = (_movieCardPage.value - index);
                    final scale = ui.lerpDouble(1, .8, progress.abs())!;
                    final isCurrentPage = index == _movieCardIndex.value;
                    final isScrolling = _movieCardPageController
                        .position.isScrollingNotifier.value;
                    final isFirstPage = index == 0;

                    return Transform.scale(
                      alignment: Alignment.lerp(
                        Alignment.topLeft,
                        Alignment.center,
                        -progress,
                      ),
                      scale: isScrolling && isFirstPage ? 1 - progress : scale,
                      child: GestureDetector(
                        onTap: () {
                          /*  _showMovieDetails.value = !_showMovieDetails.value;
                        const transitionDuration = Duration(milliseconds: 550);
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            transitionDuration: transitionDuration,
                            reverseTransitionDuration: transitionDuration,
                            pageBuilder: (_, animation, ___) {
                              return FadeTransition(
                                opacity: animation,
                                child: MoviePage(movie: movie),
                              );
                            },
                          ),
                        );
                        Future.delayed(transitionDuration, () {
                          _showMovieDetails.value = !_showMovieDetails.value;
                        }); */
                        },
                        child: Hero(
                          tag: movie.name,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            transform: Matrix4.identity()
                              ..translate(
                                isCurrentPage ? 0.0 : -20.0,
                                isCurrentPage ? 0.0 : 60.0,
                              ),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(70),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 25,
                                  offset: const Offset(0, 25),
                                  color: Colors.black.withOpacity(.2),
                                ),
                              ],
                              /* image: DecorationImage(
                                image: AssetImage(movie.name),
                                fit: BoxFit.cover,
                              ), */
                            ),
                            child: Center(child: Text(movie.name)),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ]);
    }));
  }
}
