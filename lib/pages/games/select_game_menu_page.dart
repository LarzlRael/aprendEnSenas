part of '../pages.dart';

class SelectGameMenuPage extends HookConsumerWidget {
  const SelectGameMenuPage({super.key});
  static const routeName = '/select_game_menu_page';
  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(
        /* leading: BackIcon(margin: const EdgeInsets.only(left: 10)), */
        title: Text(AppLocalizations.of(context)!.select_a_game),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Stack(
          children: [
            AlignedGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              itemCount: selecteGameItems(context).length,
              itemBuilder: (_, index) {
                final item = selecteGameItems(context)[index];
                return SelectGameCard(
                  icon: item.icon,
                  title: item.title,
                  subtitle: item.subtitle,
                  onSelected: item.onSelected,
                );
              },
            ),
            /*  Align(
              alignment: Alignment.bottomCenter,
              child: BannerAd(),
            ), */
          ],
        ),
      ),
    );
  }
}
