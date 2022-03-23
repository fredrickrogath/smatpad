import 'package:path/path.dart';
import 'package:smatpad/model/item.dart';
import 'package:sqflite/sqflite.dart';

class itemsDatabase {
  static final itemsDatabase instance = itemsDatabase._init();

  static Database? _database;

  itemsDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('test.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(
    Database db,
    int version,
  ) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const textType = "TEXT NULL";
    const doubleType = "DOUBLE NULL";

    await db.execute('''
  CREATE TABLE $tableItems (
  ${itemFields.id} $idType,
  ${itemFields.quantity} $doubleType,
  ${itemFields.sale_price} $doubleType,
  ${itemFields.purchase_price} $doubleType,
  ${itemFields.image_path} $textType,
  ${itemFields.name} $textType,
  ${itemFields.item_code} $textType,
  ${itemFields.expiry} $textType,
  ${itemFields.primary_unit} $textType,
  ${itemFields.secondary_unit} $textType,
  ${itemFields.primary_unit_cost} $doubleType,
  ${itemFields.secondary_unit_cost} $doubleType,
  ${itemFields.category} $textType,
  ${itemFields.aboutItem} $textType,
  ${itemFields.created_at} $textType
  )
  ''');
  }

  Future<Item> create(Item item) async {
    final db = await instance.database;
    final id = await db.insert(tableItems, item.toJson());
    return item.copy(id: id);
  }

  Future<Item> readItem(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableItems,
      columns: itemFields.values,
      where: '${itemFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Item.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Item>> readAllItems() async {
    final db = await instance.database;

    const orderBy = '${itemFields.created_at} ASC';
    final result = await db.query(tableItems, orderBy: orderBy);
    return result.map((json) => Item.fromJson(json)).toList();
  }

  Future<List<Item>> readProducts() async {
    final db = await instance.database;

    const orderBy = '${itemFields.created_at} ASC';
    const where = '${itemFields.category} = product';
    final result = await db.query(tableItems, orderBy: orderBy, where: where);
    return result.map((json) => Item.fromJson(json)).toList();
  }

  Future<int> update(Item item) async {
    final db = await instance.database;

    return db.update(tableItems, item.toJson(),
        where: '${itemFields.id} = ?', whereArgs: [item.id]);
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableItems,
      where: '${itemFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
