part of 'utils.dart';

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
