part of '../widgets/widgets.dart';

const timeMiliseconds = 750;

class PageViewSignSlider extends HookWidget {
  const PageViewSignSlider({super.key, required this.singList});
  final List<Sign> singList;
  @override
  Widget build(BuildContext context) {
    final pagerController = usePageController();
    final timerState = useState<Timer?>(null);
    final isInProgress = useState(false);

    void restartTimer() {
      timerState.value?.cancel();
      timerState.value = Timer.periodic(Duration(milliseconds: timeMiliseconds),
          (Timer timer) {
        if (pagerController.page!.toInt() < singList.length - 1) {
          isInProgress.value = true;
          pagerController.nextPage(
              duration: Duration(milliseconds: timeMiliseconds),
              curve: Curves.easeIn);
        } else {
          pagerController.jumpToPage(0);
          timer.cancel();
          timerState.value?.cancel();
          timerState.value = null;
          isInProgress.value = false;
        }
      });
    }

    useEffect(() {
      restartTimer();
      return pagerController.dispose;
    }, [singList]);

    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            key: key,
            controller: pagerController,
            itemCount: singList.length,
            itemBuilder: (context, int index) {
              return Container(
                child: Card(
                  /* child: SvgPicture.asset(
                    singList[index].icon,
                  ), */
                  child: Icon(
                    singList[index].iconSign,
                    size: 300,
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 15),
          height: 50,
          child: FilledButton.icon(
            onPressed: isInProgress.value ? null : restartTimer,
            icon: Icon(Icons.refresh),
            label: Text('Reiniciar'),
          ),
        ),
      ],
    );
  }
}
