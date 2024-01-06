// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'utils.dart';

class ItemModel {
  final String name;
  String? value;
  IconData icon;
  bool? accepting;

  ItemModel({
    required this.name,
    required this.icon,
    String? value,
    this.accepting = false,
  }) : value = value ?? name.toLowerCase().removeDiacriticsFromString();

  ItemModel copyWith({
    String? name,
    String? value,
    IconData? icon,
    bool? accepting,
  }) {
    return ItemModel(
      name: name ?? this.name,
      value: value ?? this.value,
      icon: icon ?? this.icon,
      accepting: accepting ?? this.accepting,
    );
  }
}

final dataDragNDrop = <ItemModel>[
  ItemModel(icon: FontAwesomeIcons.hippo, name: 'Hipopotamo'),
  ItemModel(icon: FontAwesomeIcons.dog, name: "Perro"),
  ItemModel(icon: FontAwesomeIcons.cat, name: "Gato"),
  ItemModel(icon: FontAwesomeIcons.fish, name: "Pez"),
  ItemModel(icon: FontAwesomeIcons.dragon, name: "Dragon"),
  ItemModel(icon: FontAwesomeIcons.worm, name: "Gusano"),
  ItemModel(icon: FontAwesomeIcons.spider, name: "Araña"),
  ItemModel(icon: FontAwesomeIcons.horse, name: "Caballo"),
  ItemModel(icon: FontAwesomeIcons.frog, name: "Rana"),
  ItemModel(icon: FontAwesomeIcons.dove, name: "Pajaro"),
  ItemModel(icon: FontAwesomeIcons.crow, name: "Cuervo"),
  ItemModel(icon: FontAwesomeIcons.cow, name: "Vaca"),
];

List<ItemModel> getNelemets(int n) {
  dataDragNDrop.shuffle();
  return dataDragNDrop.take(n).toList();
}
