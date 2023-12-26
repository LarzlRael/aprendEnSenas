part of 'utils.dart';

List<String> imageSource() {
  return [
    'assets/images/image_1.png',
    'assets/images/image_2.png',
    'assets/images/image_3.png',
    'assets/images/image_4.png',
    'assets/images/image_5.png',
    'assets/images/image_6.png',
    'assets/images/image_7.png',
    'assets/images/image_8.png',
    'assets/images/image_1.png',
    'assets/images/image_2.png',
    'assets/images/image_3.png',
    'assets/images/image_4.png',
    'assets/images/image_5.png',
    'assets/images/image_6.png',
    'assets/images/image_7.png',
    'assets/images/image_8.png',
  ];
}

List<Sign> createShuffledListFromImageSource(int amount) {
  return generateSignToPair(listOnlySingAndNumbers, amount);
}

List<bool> getInitialItemStateList(int amount) =>
    List.generate(amount, (index) => true).toList();

List<GlobalKey<FlipCardState>> createFlipCardStateKeysList(int amount) {
  List<GlobalKey<FlipCardState>> cardStateKeys = <GlobalKey<FlipCardState>>[];
  for (int i = 0; i < amount; i++) {
    cardStateKeys.add(GlobalKey<FlipCardState>());
  }
  return cardStateKeys;
}
