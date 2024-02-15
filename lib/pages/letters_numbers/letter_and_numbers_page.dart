part of '../pages.dart';

class LetterAndNumbersPage extends HookConsumerWidget {
  const LetterAndNumbersPage({super.key});
  static const routeName = '/letter_and_numbers_page';

  @override
  Widget build(BuildContext context, ref) {
    final currentSignList = ref.watch(signProvider).currentListSing;
    void onSelected(Sign sing) => context.push('${routeName}/${sing.letter}');

    final isSwitched = useState(false);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.letters_and_numbers),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        // Add your widget code here
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CheckboxLabel(
                label: AppLocalizations.of(context)!.change_view,
                value: isSwitched.value,
                onChanged: (value) {
                  isSwitched.value = value;
                }),
            Expanded(
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 350),
                child: isSwitched.value
                    ? ListGrid(
                        onTap: onSelected,
                        key: UniqueKey(),
                        currentSignList: currentSignList,
                      )
                    : ListRow(
                        onTap: onSelected,
                        key: UniqueKey(),
                        currentSignList: currentSignList,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListRow extends StatelessWidget {
  final Function(Sign sing)? onTap;
  final List<Sign> currentSignList;
  const ListRow({super.key, this.onTap, required this.currentSignList});
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => SizedBox(height: 5),
      itemCount: currentSignList.length,
      itemBuilder: (BuildContext context, int index) {
        final listItem = currentSignList[index];
        return InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onTap: () {
            if (onTap != null) {
              onTap!(listItem);
            }
          },
          child: Card(
            child: Container(
              padding: EdgeInsets.all(10),
              child: ListTile(
                /*  onTap: () {
                  if (onTap != null) {
                    onTap!(list);
                  }
                }, */
                leading: SignIcon(
                  icon: listItem.iconSign,
                  size: 50,
                ),
                title: Text(
                  listItem.letter,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ); //) Cambia el color de tu SVG);
      },
    );
  }
}

class ListGrid extends StatelessWidget {
  final List<Sign> currentSignList;
  const ListGrid({super.key, this.onTap, required this.currentSignList});
  final Function(Sign sing)? onTap;
  @override
  Widget build(BuildContext context) {
    return ListGridSign(
      listSign: currentSignList,
      onTap: onTap,
    );
  }
}
