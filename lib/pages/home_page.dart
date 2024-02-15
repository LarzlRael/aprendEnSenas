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

class HomePage extends HookConsumerWidget {
  const HomePage({super.key, this.phrase});
  final String? phrase;
  static const routeName = '/home_page';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _selectedIndex = useState(0);
    void _onItemTapped(int index) => _selectedIndex.value = index;
    useEffect(() {
      Future.delayed(Duration.zero, () {
        ref.read(signProvider.notifier).setCurrentMessage(phrase ?? '');
      });
    }, []);

    final List<ItemMenu> listMenu = [
      /* ItemMenu(title: 'Home', page: HomePage()), */
      ItemMenu(
        title: AppLocalizations.of(context)!.send_message,
        page: SendMessageWithSignPage(),
        icon: CustomIcons.ic_conversation,
      ),
      ItemMenu(
        title: AppLocalizations.of(context)!.letters_and_numbers,
        page: LetterAndNumbersPage(),
        icon: CustomIcons.ic_words,
      ),
      ItemMenu(
        title: AppLocalizations.of(context)!.games,
        page: SelectGameMenuPage(),
        icon: CustomIcons.ic_puzzle,
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
