part of '../widgets.dart';

class ListGridSign extends StatelessWidget {
  final List<Sign> listSign;
  final Function(Sign sing)? onTap;
  const ListGridSign({super.key, this.onTap, required this.listSign});
  @override
  Widget build(BuildContext context) {
    return AlignedGridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 5,
      crossAxisSpacing: 5,
      itemCount: listSign.length,
      itemBuilder: (context, int index) {
        final listIndex = listSign[index];
        return SignCard(
          sign: listIndex,
          onSelected: onTap,
        );
      },
    );
  }
}

class SignCard extends StatelessWidget {
  final Sign sign;
  final Function(Sign sign)? onSelected;

  const SignCard({super.key, required this.sign, this.onSelected});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      onTap: () {
        if (onSelected != null) {
          onSelected!(sign);
        }
      },
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              sign.letter.toUpperCase(),
              style: TextStyle(
                fontSize: sign.letter.length > 1 ? 40 : 50,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
            Container(
              padding: EdgeInsets.all(10),
              width: 100,
              height: 100,
              child: SignIcon(
                icon: sign.iconSign,
                size: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
