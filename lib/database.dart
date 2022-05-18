import 'package:sqflite/sqflite.dart';

class SQLHelper {
  static Future<void> createTables(Database database) async {
    await database.execute("""
        CREATE TABLE items(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT,
        checked INT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }
// id: the id of the note
// title : name and description of your activity
// checked : value for checkbox
// created_at : the time that the item was created.

  static Future<Database> db() async {
    return openDatabase(
      'noteTable.db',
      version: 1,
      onCreate: (Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new item
  static Future<int> createItem(String title) async {
    final db = await SQLHelper.db();

    final data = {'title': title, 'checked': 0};
    final id = await db.insert('items', data,
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  // Read all items
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('items', orderBy: "id");
  }

  // Delete an item
  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    await db.delete("items", where: "id = ?", whereArgs: [id]);
  }

  //Delete all items
  static Future<void> deleteAllItem() async {
    final db = await SQLHelper.db();
    await db.delete("items");
  }

  //update checked value
  static Future<void> updatecheckvalue(
      int? id, String title, int checkvalue) async {
    final db = await SQLHelper.db();
    final data = {
      'title': title,
      'checked': (checkvalue == 0) ? 1 : 0,
      'createdAt': DateTime.now().toString()
    };
    await db.update('items', data, where: "id = ?", whereArgs: [id]);
  }
}
