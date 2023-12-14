part of '../pages.dart';

class SelectGameMenuPage extends StatelessWidget {
  const SelectGameMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Selecciona un juego"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: AlignedGridView.count(
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
      ),
    );
  }
}
