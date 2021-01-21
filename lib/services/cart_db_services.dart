part of 'services.dart';

class CartDbServices {
  Database db;

  CartDbServices() {
    init();
  }

  void init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "items.db");
    db = await openDatabase(path, version: 1,
        onCreate: (Database newDb, int version) {
      newDb.execute("""
        CREATE TABLE Items
        (
          id TEXT PRIMARY KEY,
          date TEXT,
          quantity INTEGER,
          product_id INTEGER,
          price INTEGER,
          name TEXT,
          brand_name TEXT,
          package_name TEXT,
          image_url TEXT,
          rating REAL
        )
      """);
    });
  }

  Future<List<CartItem>> fetchItems() async {
    final maps = await db.query(
      "Items",
      columns: null, // entire columns
    );

    if (maps.length > 0) {
      return maps.map((item) => CartItem.fromDb(item)).toList();
    }

    return [];
  }

  Future<int> addItem(CartItem item) {
    return db.insert(
      "Items",
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm
          .ignore, // the simplest way handling conflict add to sql
    );
  }

  Future<int> changeItem(CartItem item) {
    return db.update("Items", item.toMap(id: false),
        where: "product_id = ? AND date = ?",
        whereArgs: [item.product.id, '${item.dateTime}']);
  }

  Future delete(CartItem item) {
    return db.delete("Items",
        where: "id = ?", whereArgs: ['${item.product.id}-${item.dateTime}']);
  }

  Future<int> clear() {
    return db.delete("Items");
  }
}

final cartDbServices = CartDbServices();
