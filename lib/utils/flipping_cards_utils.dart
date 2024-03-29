part of 'utils.dart';

List<Sign> createShuffledListFromImageSource(List<Sign> sing, int amount) {
  return generateSignToPair(signStyle1, amount);
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
