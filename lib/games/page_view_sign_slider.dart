part of '../widgets/widgets.dart';

class PageViewSignSlider extends HookWidget {
  const PageViewSignSlider({super.key, required this.singList});
  final List<Sign> singList;
  @override
  Widget build(BuildContext context) {
    final controller = usePageController();
    final timer = useState<Timer?>(null);

    /*  useEffect(() {
      print('useEffect');
      print(singList.length);

      timer.value = Timer.periodic(Duration(seconds: 1000), (Timer timer) {
        if (controller.page! < singList.length - 1) {
          controller.nextPage(
              duration: Duration(milliseconds: 300), curve: Curves.easeIn);
        } else {
          controller.jumpToPage(0);
        }
      });
      return controller.dispose;
    }, [singList]); */
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            key: PageStorageKey('pageViewSignSlider'),
            controller: controller,
            itemCount: singList.length,
            itemBuilder: (context, int index) {
              return Container(
                child: SvgPicture.asset(
                  singList[index].pathImage,
                ),
              );
            },
          ),
        ),
        FilledButton.icon(
          onPressed: () {
            if (timer.value != null) {
              timer.value!.cancel();
              timer.value =
                  Timer.periodic(Duration(seconds: 1000), (Timer timer) {
                if (controller.page! < singList.length - 1) {
                  controller.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeIn);
                } else {
                  controller.jumpToPage(0);
                }
              });
            }
          },
          icon: Icon(Icons.refresh),
          label: Text('Reiniciar'),
        ),
      ],
    );
  }
}
