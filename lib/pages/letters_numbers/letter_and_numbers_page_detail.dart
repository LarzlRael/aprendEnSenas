part of '../pages.dart';

class LetterAndNumbersPageDetail extends HookConsumerWidget {
  final String signChar;
  const LetterAndNumbersPageDetail({super.key, required this.signChar});
  static const routeName = '/letter_and_numbers_page_detail';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signState = useState<List<Sign>>([]);
    final isRotated = ref.watch(settingsProvider).isTurned;
    useEffect(() {
      signState.value =
          getIconSign(signChar, ref.read(signProvider).currentListSing)!;
      return;
    }, [signChar]);
    final appBarTitle = signState.value.length == 1
        ? "${signState.value.first.type!.name} ${signState.value.first.letter}"
        : signState.value.map((e) => e.letter).join("");

    final currentLetterOrPhrase = signState.value.length == 1
        ? signState.value.first.letter
        : signState.value.map((e) => e.letter).join("");
    ;
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle.toCapitalize()),
        actions: [
          IconButton(
            onPressed: () => ShareServiceImp().shareOnlyText(
              shareString(routeName, currentLetterOrPhrase),
            ),
            icon: Icon(Icons.share),
          ),
        ],
        leading: BackIcon(
          margin: EdgeInsets.only(left: 10),
        ),
      ),
      body: signState.value.length == 1
          ? OneLetterAndNumbers(
              sign: signState.value.first, isRotated: isRotated)
          : ListGridSign(
              listSign: signState.value,
              onTap: (sing) => context.push(
                    '${LetterAndNumbersPage.routeName}/${sing.letter}',
                  )),
    );
  }
}

class OneLetterAndNumbers extends StatelessWidget {
  final bool isRotated;
  final Sign sign;
  const OneLetterAndNumbers({
    super.key,
    required this.sign,
    required this.isRotated,
  });
  @override
  Widget build(BuildContext context) {
    print(sign.letter);
    final style = TextStyle(fontSize: 175, fontWeight: FontWeight.w600);
    final media = MediaQuery.of(context).size;
    return SizedBox.expand(
      /* color: Colors.amber, */
      /* width: media.width * 0.75,
        height: media.height * 0.65, */
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            child: isRotated
                ? Icon(
                    sign.iconSign,
                    size: 225,
                    color: Colors.grey.withOpacity(0.3),
                  )
                : Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(math.pi),
                    child: Icon(
                      sign.iconSign,
                      size: 225,
                      color: Colors.grey.withOpacity(0.3),
                    ),
                  ),
          ),
          Align(
            alignment: Alignment.center,
            child: Card(
              child: Container(
                width: media.width * 0.90,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform.translate(
                      offset: Offset(0, -35),
                      child: Text(
                        sign.letter,
                        style: sign.letter.length > 1
                            ? style.copyWith(fontSize: 100)
                            : style,
                      ),
                    ),
                    Hero(
                      tag: sign.letter,
                      child: SignIcon(
                        icon: sign.iconSign,
                        size: 175,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: BannerAd(),
          ),
        ],
      ),
    );
  }
}
