part of '../pages.dart';

class WelcomeSLider {
  final String title;
  final String subtitle;
  final String image;
  WelcomeSLider({
    required this.title,
    required this.subtitle,
    required this.image,
  });
}

const horizontalPadding = 20.0;
List<WelcomeSLider> welcomeSlides(BuildContext context) {
  return [
    WelcomeSLider(
      title: '${AppLocalizations.of(context)!.welcome_title_1} $appName',
      subtitle: AppLocalizations.of(context)!.welcome_subtitle_1,
      image: logoPath,
    ),
    WelcomeSLider(
      title: AppLocalizations.of(context)!.welcome_subtitle_2,
      subtitle: AppLocalizations.of(context)!.welcome_subtitle_2,
      image: 'assets/welcome_images/welcome_1.png',
    ),
    WelcomeSLider(
      title: AppLocalizations.of(context)!.welcome_title_3,
      subtitle: AppLocalizations.of(context)!.welcome_subtitle_3,
      image: 'assets/welcome_images/welcome_3.png',
    ),
    WelcomeSLider(
      title: AppLocalizations.of(context)!.welcome_title_4,
      subtitle: AppLocalizations.of(context)!.welcome_subtitle_3,
      image: 'assets/welcome_images/welcome_2.jpg',
    ),
  ];
}

class WelcomePage extends HookWidget {
  const WelcomePage({super.key});
  static const routeName = '/welcome_page';
  @override
  Widget build(BuildContext context) {
    /* local states */
    final isLastPage = useState(false);
    /* UI */
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;
    /* Controller */
    final welcomeSlide = welcomeSlides(context);
    final controller = SwiperController();
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: [
            Positioned(
              top: kToolbarHeight,
              right: 10,
              child: TextButton(
                child: Text(AppLocalizations.of(context)!.skip),
                onPressed: () => controller.move(welcomeSlide.length - 1),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: size.height * 0.65,
                child: Swiper(
                  controller: controller,
                  itemCount: welcomeSlide.length,
                  onIndexChanged: (index) {
                    /* Other way
                    if (index == welcomeSlides.length - 1) {
                      isLastPage.value = true;
                    } else {
                      isLastPage.value = false;
                    }
                    */
                    isLastPage.value = index == welcomeSlide.length - 1;
                  },
                  itemBuilder: (_, index) {
                    final slide = welcomeSlide[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          slide.image,
                          fit: BoxFit.fill,
                          height: size.height * 0.35,
                        ),
                        SimpleText(
                          text: slide.title,
                          style: textTheme.headlineSmall,
                          textAlign: TextAlign.start,
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: horizontalPadding,
                          ),
                        ),
                        SimpleText(
                          text: slide.subtitle,
                          style: textTheme.labelLarge!.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: horizontalPadding,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    );
                  },
                  pagination: SwiperPagination(
                    builder: DotSwiperPaginationBuilder(
                      color: Colors.grey,
                      activeColor: colors.primary,
                      size: 10,
                      activeSize: 15,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 15,
              right: 15,
              child: AnimatedOpacity(
                opacity: isLastPage.value ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                child: FilledButton(
                  onPressed: () => goToNextPage(context),
                  child: Text(AppLocalizations.of(context)!.start),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void goToNextPage(BuildContext context) async {
    await KeyValueStorageServiceImpl().setKeyValue<bool>(
      IS_FIRST_TIME_KEY,
      false,
    );
    context.go(HomePage.routeName);
  }
}
