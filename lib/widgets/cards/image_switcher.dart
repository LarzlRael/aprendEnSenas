part of '../widgets.dart';

class ImageSwitcher extends HookWidget {
  final List<Sign> imagesPaths;

  ImageSwitcher({
    required this.imagesPaths,
  });

  @override
  Widget build(BuildContext context) {
    final _currentIndex = useState<int>(0);
    final _timer = useState<Timer?>(null);
    void startTimer() {
      _timer.value = Timer.periodic(const Duration(seconds: 1), (timer) async {
        _currentIndex.value = _currentIndex.value + 1;
        if (_currentIndex.value == imagesPaths.length) {
          _currentIndex.value = 0;
          _timer.value?.cancel();
          timer.cancel();
        }
      });
    }

    useEffect(() {
      /* startTimer(); */
      return () {
        _timer.value?.cancel();
      };
    }, [imagesPaths]);

    return Container(
      width: 300,
      height: 400,
      child: Center(
        child: Column(
          children: [
            FilledButton(
              onPressed: startTimer,
              child: Text('Empezar'),
            ),
            imagesPaths.isEmpty
                ? const SizedBox()
                : Expanded(
                    child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        child: Card(
                          child: SvgPicture.asset(
                            imagesPaths[_currentIndex.value].pathImage,
                            key: ValueKey<int>(_currentIndex.value),
                            /*   width: 200,
                            height: 200, */
                          ),
                        )),
                  ),
            SimpleText(
              text: imagesPaths.map((sign) => sign.letter).join(''),
              fontSize: 17,
              fontWeight: FontWeight.w700,
              padding: EdgeInsets.symmetric(vertical: 10),
            ),
          ],
        ),
      ),
    );
  }
}
