part of '../pages.dart';

class SelectGameMenuPage extends HookConsumerWidget {
  const SelectGameMenuPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final counter = useState(0);
    /* final intersitialAd = ref.watch(adIntersitialProvider);
    ref.listen(adIntersitialProvider, (previous, next) {
      if (!next.hasValue) return;
      if (next.value == null) return;
      if (counter.value == 2) next.value!.show();
    }); */
    InterstitialAdManager.showAd();
    /* if (intersitialAd.isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } */
    return Scaffold(
      appBar: AppBar(
        leading: BackIcon(margin: const EdgeInsets.only(left: 10)),
        title: Text("Selecciona un juego "),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              counter.value++;
              if (counter.value == 2) {
                /* counter.value = 0; */
              }
            },
          ),
          Text(counter.value.toString()),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Stack(
          children: [
            AlignedGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              itemCount: items.length,
              itemBuilder: (context, int index) {
                final item = items[index];
                return SelectGameCard(
                  icon: item.icon,
                  title: item.title,
                  subtitle: item.subtitle,
                  onSelected: item.onSelected,
                );
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: BannerAd(),
            ),
          ],
        ),
      ),
    );
  }
}
