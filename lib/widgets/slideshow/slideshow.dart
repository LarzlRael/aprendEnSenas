// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../widgets.dart';

class Slideshow extends StatelessWidget {
  final List<Widget> slides;
  final bool indicatorTopPosition;
  final Color primaryColor;
  final Color secondaryColor;
  final double primaryBullet;
  final double secondaryBullet;

  const Slideshow({
    Key? key,
    required this.slides,
    this.indicatorTopPosition = false,
    this.primaryBullet = 12.0,
    this.secondaryBullet = 12.0,
    required this.primaryColor,
    required this.secondaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderState.ChangeNotifierProvider(
      create: (_) => SlideShowModel(),
      child: SafeArea(
        child: Center(
          child: Builder(
            builder: (context) {
              final ssModel =
                  ProviderState.Provider.of<SlideShowModel>(context);
              ssModel.primaryColorValue(primaryColor);
              ssModel.secondaryColorValue(secondaryColor);
              ssModel.primaryBulletValue(primaryBullet);
              ssModel.secondaryBulletValue(secondaryBullet);
              return _CreateSlideShow(
                indicatorTopPosition: indicatorTopPosition,
                slides: slides,
                primaryColor: primaryColor,
                secondaryColor: secondaryColor,
              );
            },
          ),
        ),
      ),
    );
  }
}

class _CreateSlideShow extends StatelessWidget {
  const _CreateSlideShow({
    Key? key,
    required this.indicatorTopPosition,
    required this.slides,
    required this.primaryColor,
    required this.secondaryColor,
  }) : super(key: key);

  final bool indicatorTopPosition;
  final List<Widget> slides;
  final Color primaryColor;
  final Color secondaryColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (indicatorTopPosition)
          _Dots(
            totalSlides: slides.length,
            primaryColor: primaryColor,
            secondaryColor: secondaryColor,
          ),
        Expanded(
          /* color: Colors.blue,
          height: MediaQuery.of(context).size.height * 0.48, */
          child: _Slides(slides: slides),
        ),
        if (!indicatorTopPosition)
          _Dots(
            totalSlides: slides.length,
            primaryColor: primaryColor,
            secondaryColor: secondaryColor,
          )
      ],
    );
  }
}

class _Dots extends StatelessWidget {
  final int totalSlides;
  final Color primaryColor;
  final Color secondaryColor;
  const _Dots({
    Key? key,
    required this.totalSlides,
    required this.primaryColor,
    required this.secondaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          totalSlides,
          (index) => _Dot(
            index: index,
            primaryColor: primaryColor,
            secondaryColor: secondaryColor,
          ),
        ),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final int index;
  final Color primaryColor;
  final Color secondaryColor;
  const _Dot({
    Key? key,
    required this.index,
    required this.primaryColor,
    required this.secondaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ssModel = ProviderState.Provider.of<SlideShowModel>(context);
    Color color;
    double size;
    if (ssModel.state.currentPage >= index - 0.5 &&
        ssModel.state.currentPage <= index + 0.5) {
      size = ssModel.state.primaryBullet;
      color = ssModel.state.primaryColor;
    } else {
      size = ssModel.state.secondaryBullet;
      color = ssModel.state.secondaryColor;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: size,
      height: size,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _Slides extends StatefulWidget {
  final List<Widget> slides;
  const _Slides({
    Key? key,
    required this.slides,
  }) : super(key: key);

  @override
  State<_Slides> createState() => _SlidesState();
}

class _SlidesState extends State<_Slides> {
  final pageViewController = PageController();

  @override
  void initState() {
    super.initState();
    pageViewController.addListener(() {
      final ssModel =
          ProviderState.Provider.of<SlideShowModel>(context, listen: false);
      ssModel.currentPageValue(pageViewController.page!);

      /* context.read<GlobalProvider>().setIsLastPageSlider =
          pageViewController.page!.toInt() == widget.slides.length - 1; */
    });
  }

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      /* color: Colors.blue, */
      padding: const EdgeInsets.all(10),
      child: PageView(
        controller: pageViewController,
        children: widget.slides
            .map((slide) => _Slide(
                  slide: slide,
                ))
            .toList(),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Widget slide;

  const _Slide({Key? key, required this.slide}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(10),
      child: slide,
    );
  }
}

class SlideShowModel with ChangeNotifier {
  SlideShowState state = SlideShowState(
    currentPage: 0,
    primaryColor: Colors.blue,
    secondaryColor: Colors.grey,
    primaryBullet: 12.0,
    secondaryBullet: 12.0,
  );

  void currentPageValue(double value) {
    state = state.copyWith(currentPage: value);
    notifyListeners();
  }

  void primaryColorValue(Color value) {
    state = state.copyWith(primaryColor: value);
    notifyListeners();
  }

  void secondaryColorValue(Color value) {
    state = state.copyWith(secondaryColor: value);
    notifyListeners();
  }

  void primaryBulletValue(double value) {
    state = state.copyWith(primaryBullet: value);
    notifyListeners();
  }

  void secondaryBulletValue(double value) {
    state = state.copyWith(secondaryBullet: value);
    notifyListeners();
  }
}

class SlideShowState {
  final double currentPage;
  final Color primaryColor;
  final Color secondaryColor;
  final double primaryBullet;
  final double secondaryBullet;

  SlideShowState({
    required double this.currentPage,
    required Color this.primaryColor,
    required Color this.secondaryColor,
    required double this.primaryBullet,
    required double this.secondaryBullet,
  });

  SlideShowState copyWith({
    double? currentPage,
    Color? primaryColor,
    Color? secondaryColor,
    double? primaryBullet,
    double? secondaryBullet,
  }) {
    return SlideShowState(
      currentPage: currentPage ?? this.currentPage,
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      primaryBullet: primaryBullet ?? this.primaryBullet,
      secondaryBullet: secondaryBullet ?? this.secondaryBullet,
    );
  }
}
