part of 'pages.dart';

class ItemMenu {
  final String title;
  final Widget page;
  final IconData icon;
  ItemMenu({
    required this.title,
    required this.page,
    required this.icon,
  });
}

class HomePage extends HookWidget {
  const HomePage({super.key, this.phrase});
  final String? phrase;
  static const routeName = '/home_page';

  @override
  Widget build(BuildContext context) {
    final _selectedIndex = useState(0);
    void _onItemTapped(int index) => _selectedIndex.value = index;
    final List<ItemMenu> listMenu = [
      /* ItemMenu(title: 'Home', page: HomePage()), */
      ItemMenu(
        title: 'Enviar mensaje',
        page: SendMessageWithSignPage(phrase: phrase),
        icon: IconsCustom.ic_conversation,
      ),
      ItemMenu(
        title: 'Letrás y números',
        page: LetterAndNumbersPage(),
        icon: IconsCustom.ic_words,
      ),
      ItemMenu(
        title: 'Juegos',
        page: SelectGameMenuPage(),
        icon: IconsCustom.ic_puzzle,
      ),
      /* ItemMenu(title: 'Settings', page: SettingsPage()), */
    ];
    /* const TextStyle optionStyle =
        TextStyle(fontSize: 30, fontWeight: FontWeight.bold); */
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: listMenu.elementAt(_selectedIndex.value).page,
      bottomNavigationBar: GNav(
        selectedIndex: _selectedIndex.value,
        onTabChange: _onItemTapped,
        activeColor: colors.primary,
        gap: 8,
        tabs: listMenu
            .map((e) => GButton(
                  icon: e.icon,
                  text: e.title,
                ))
            .toList(),
        /* currentIndex: _selectedIndex.value,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped, */
      ),
    );
  }
}
