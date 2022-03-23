class Cart {
  final int? id;
  var count = 0;
  final double sale_price;
  final String image_path, name, category;

  int? get getId => id;
  int get getCount => count;
  String get getName => name;
  String get getCategory => category;
  double get getSalePrice => sale_price;
  String get getImagePath => image_path;


   Cart({
    this.id,
    required this.name,
    required this.count,
    required this.category,
    required this.image_path,
    required this.sale_price,
  });

}
