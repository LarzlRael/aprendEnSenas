part of 'pages.dart';

class LetterAndNumbersPage extends StatelessWidget {
  const LetterAndNumbersPage({super.key});
  static const routeName = '/letter_and_numbers_page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MyStatelessWidget(
          onSelected: (selected) {
            context.push('${routeName}/${selected.letter}');
          },
        ),
      ),
    );
  }
}

/* stless widget */
class MyStatelessWidget extends HookWidget {
  const MyStatelessWidget({
    Key? key,
    this.onSelected,
  }) : super(key: key);
  final Function(Sign sing)? onSelected;

  @override
  Widget build(BuildContext context) {
    final isSwitched = useState(false);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      // Add your widget code here
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SwitchListTile(
              title: Text("Cambiar vista"),
              value: isSwitched.value,
              onChanged: (value) {
                isSwitched.value = value;
              }),
          Expanded(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              child: isSwitched.value
                  ? ListGrid(onTap: onSelected, key: UniqueKey())
                  : ListRow(onTap: onSelected, key: UniqueKey()),
            ),
          ),
        ],
      ),
    );
  }
}

class ListRow extends StatelessWidget {
  final Function(Sign sing)? onTap;
  const ListRow({super.key, this.onTap});
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => SizedBox(height: 13),
      itemCount: listOnlySingAndNumbers.length,
      itemBuilder: (BuildContext context, int index) {
        final list = listOnlySingAndNumbers[index];
        return Card(
          child: Container(
            padding: EdgeInsets.all(10),
            child: ListTile(
              onTap: () {
                if (onTap != null) {
                  onTap!(list);
                }
              },
              leading: ColoredIcon(
                icon: list.iconSign,
                size: 50,
              ),
              title: Text(
                list.letter,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ); //) Cambia el color de tu SVG);
      },
    );
  }
}

class ListGrid extends StatelessWidget {
  const ListGrid({super.key, this.onTap});
  final Function(Sign sing)? onTap;
  @override
  Widget build(BuildContext context) {
    return ListGridSign(
      listSign: listOnlySingAndNumbers,
      onTap: onTap,
    );
  }
}
