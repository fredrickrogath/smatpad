final String tableItems = 'items';

class itemFields {
  static final List<String> values = [
    id,
    item_code,
    sale_price,
    purchase_price,
    quantity,
    primary_unit_cost,
    secondary_unit_cost,
    image_path,
    name,
    expiry,
    primary_unit,
    secondary_unit,
    category,
    aboutItem,
    created_at
  ];

  static const String id = '_id';
  static const String quantity = 'quantity';
  static const String sale_price = 'sale_price';
  static const String purchase_price = 'purchase_price';
  static const String image_path = 'image_path';
  static const String name = 'name';
  static const String expiry = 'expiry';
  static const String primary_unit = 'primary_unit';
  static const String primary_unit_cost = 'primary_unit_cost';
  static const String secondary_unit = 'secondary_unit';
  static const String secondary_unit_cost = 'secondary_unit_cost';
  static const String category = 'category';
  static const String aboutItem = 'aboutItem';
  static const String item_code = 'item_code';
  static const String created_at = 'created_at';
}

class Item {
  final int? id;
  final double sale_price,
      purchase_price,
      quantity,
      primary_unit_cost,
      secondary_unit_cost;
  final String image_path,
      name,
      item_code,
      expiry,
      primary_unit,
      secondary_unit,
      category,
      aboutItem;
  final DateTime created_at;

  const Item({
    this.id,
    required this.name,
    required this.expiry,
    required this.quantity,
    required this.category,
    required this.item_code,
    required this.created_at,
    required this.aboutItem,
    required this.image_path,
    required this.sale_price,
    required this.primary_unit,
    required this.secondary_unit,
    required this.purchase_price,
    required this.primary_unit_cost,
    required this.secondary_unit_cost,
  });

  static Item fromJson(Map<String, Object?> json) => Item(
        id: json[itemFields.id] as int?,
        name: json[itemFields.name] as String,
        expiry: json[itemFields.expiry] as String,
        quantity: json[itemFields.quantity] as double,
        category: json[itemFields.category] as String,
        item_code: json[itemFields.item_code] as String,
        aboutItem: json[itemFields.aboutItem] as String,
        image_path: json[itemFields.image_path] as String,
        sale_price: json[itemFields.sale_price] as double,
        primary_unit: json[itemFields.primary_unit] as String,
        secondary_unit: json[itemFields.secondary_unit] as String,
        purchase_price: json[itemFields.purchase_price] as double,
        primary_unit_cost: json[itemFields.primary_unit_cost] as double,
        secondary_unit_cost: json[itemFields.secondary_unit_cost] as double,
        created_at: DateTime.parse(json[itemFields.created_at] as String),
      );
  Map<String, Object?> toJson() => {
        itemFields.id: id,
        itemFields.name: name,
        itemFields.expiry: expiry,
        itemFields.quantity: quantity,
        itemFields.category: category,
        itemFields.item_code: item_code,
        itemFields.aboutItem: aboutItem,
        itemFields.image_path: image_path,
        itemFields.sale_price: sale_price,
        itemFields.primary_unit: primary_unit,
        itemFields.secondary_unit: secondary_unit,
        itemFields.purchase_price: purchase_price,
        itemFields.primary_unit_cost: primary_unit_cost,
        itemFields.secondary_unit_cost: secondary_unit_cost,
        itemFields.created_at: created_at.toIso8601String(),
      };
  Item copy({
    int? id,
    String? name,
    String? expiry,
    String? category,
    String? aboutItem,
    String? item_code,
    String? image_path,
    String? primary_unit,
    String? secondary_unit,
    double? quantity,
    double? sale_price,
    double? purchase_price,
    double? primary_unit_cost,
    double? secondary_unit_cost,
    DateTime? created_at,
  }) =>
      Item(
        id: id ?? this.id,
        name: name ?? this.name,
        expiry: expiry ?? this.expiry,
        quantity: quantity ?? this.quantity,
        category: category ?? this.category,
        item_code: item_code ?? this.item_code,
        aboutItem: aboutItem ?? this.aboutItem,
        image_path: image_path ?? this.image_path,
        sale_price: sale_price ?? this.sale_price,
        primary_unit: primary_unit ?? this.primary_unit,
        secondary_unit: secondary_unit ?? this.secondary_unit,
        purchase_price: purchase_price ?? this.purchase_price,
        primary_unit_cost: primary_unit_cost ?? this.primary_unit_cost,
        secondary_unit_cost: secondary_unit_cost ?? this.secondary_unit_cost,
        created_at: created_at ?? this.created_at,
      );
}
