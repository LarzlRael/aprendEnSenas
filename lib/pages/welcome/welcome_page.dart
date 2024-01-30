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
final welcomeSlides = <WelcomeSLider>[
  WelcomeSLider(
    title: 'Bienvenido a ${appName}',
    subtitle: 'Aprende y diviertete con los juegos de palabras.',
    image: logoPath,
  ),
  WelcomeSLider(
    title: 'Comunicación y aprendizaje',
    subtitle:
        'Envia mensajes a tus amigos y familiars desde la apliacio. Matente en contacto con tus seres queridos en cualquier lugar.',
    image: 'assets/welcome_images/welcome_1.png',
  ),
  WelcomeSLider(
    title: 'Aprendizaje y educación',
    subtitle:
        'Apreder cosas nuevas sobre diferentes temas de una manera divertida y entretenida. Desarrolla tus habilidades y conocimientos.',
    image: 'assets/welcome_images/welcome_3.png',
  ),
  WelcomeSLider(
    title: 'Juega y aprender',
    subtitle:
        'Diviertete jugando con los juegos de palabras. Aprende y diviertete con tus compitiendo con tus amigos.',
    image: 'assets/welcome_images/welcome_2.png',
  ),
];

class WelcomePage extends HookWidget {
  const WelcomePage({super.key});
  static const routeName = '/welcome_page';
  @override
  Widget build(BuildContext context) {
    final isLastPage = useState(false);
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: [
            Positioned(
              top: kToolbarHeight,
              right: 10,
              child: TextButton(
                child: Text('Saltar'),
                onPressed: () => goToNextPage(context),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: size.height * 0.65,
                child: Swiper(
                  itemCount: welcomeSlides.length,
                  onIndexChanged: (index) {
                    /* if (index == welcomeSlides.length - 1) {
                      isLastPage.value = true;
                    } else {
                      isLastPage.value = false;
                    } */
                    isLastPage.value = index == welcomeSlides.length - 1;
                  },
                  itemBuilder: (_, index) {
                    final slide = welcomeSlides[index];
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
                          style: textTheme.bodyMedium,
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
                  child: Text('Comenzar'),
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
