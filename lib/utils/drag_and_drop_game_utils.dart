// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'utils.dart';

class ItemModel {
  final String name;
  String? value;
  final String pathAssetImage;
  bool? accepting;

  ItemModel({
    required this.name,
    required this.pathAssetImage,
    String? value,
    this.accepting = false,
  }) : value = value ?? name.toLowerCase().removeDiacriticsFromString();

  ItemModel copyWith({
    String? name,
    String? value,
    String? pathAssetImage,
    bool? accepting,
  }) {
    return ItemModel(
      name: name ?? this.name,
      value: value ?? this.value,
      pathAssetImage: pathAssetImage ?? this.pathAssetImage,
      accepting: accepting ?? this.accepting,
    );
  }
}

/* TODO change this for names string languages */
final dataDragNDrop = <ItemModel>[
  ItemModel(pathAssetImage: 'assets/animals/abeja.png', name: 'abeja'),
  ItemModel(pathAssetImage: 'assets/animals/llama.png', name: 'llama'),
  ItemModel(pathAssetImage: 'assets/animals/pez-payaso.png', name: 'pez'),
  ItemModel(pathAssetImage: 'assets/animals/castor.png', name: 'castor'),
  ItemModel(pathAssetImage: 'assets/animals/mapache.png', name: 'mapache'),
  ItemModel(pathAssetImage: 'assets/animals/rana.png', name: 'rana'),
  ItemModel(pathAssetImage: 'assets/animals/cebra.png', name: 'cebra'),
  ItemModel(pathAssetImage: 'assets/animals/medusa.png', name: 'medusa'),
  ItemModel(pathAssetImage: 'assets/animals/raton.png', name: 'raton'),
  ItemModel(pathAssetImage: 'assets/animals/cerdo.png', name: 'cerdo'),
  ItemModel(pathAssetImage: 'assets/animals/mono.png', name: 'mono'),
  ItemModel(pathAssetImage: 'assets/animals/tortuga.png', name: 'tortuga'),
  ItemModel(pathAssetImage: 'assets/animals/gallina.png', name: 'gallina'),
  ItemModel(pathAssetImage: 'assets/animals/morsa.png', name: 'morsa'),
  ItemModel(pathAssetImage: 'assets/animals/tucan.png', name: 'tucan'),
  ItemModel(pathAssetImage: 'assets/animals/ganso.png', name: 'ganso'),
  ItemModel(pathAssetImage: 'assets/animals/oso.png', name: 'oso'),
  ItemModel(pathAssetImage: 'assets/animals/vaca.png', name: 'vaca'),
  ItemModel(pathAssetImage: 'assets/animals/gato.png', name: 'gato'),
  ItemModel(pathAssetImage: 'assets/animals/oveja.png', name: 'oveja'),
  ItemModel(pathAssetImage: 'assets/animals/zorro.png', name: 'zorro'),
  ItemModel(pathAssetImage: 'assets/animals/jirafa.png', name: 'jirafa'),
  ItemModel(pathAssetImage: 'assets/animals/perro.png', name: 'perro')
];

List<ItemModel> getNelemets(int n) {
  dataDragNDrop.shuffle();
  return dataDragNDrop.take(n).toList();
}
