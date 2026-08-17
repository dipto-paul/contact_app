import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/contact.dart';

class ContactDatabase {

  static Database? _database;


  static Future<Database> getDatabase() async {

    if (_database != null) {
      return _database!;
    }

    String databasePath = await getDatabasesPath();

    String path = join(
      databasePath, 'contact_database.db',
    );

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {

        await db.execute('''
          CREATE TABLE contacts(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            phone TEXT,
            email TEXT,
            address TEXT,
            isFavorite INTEGER
          )
        ''');
      },
    );

    return _database!;
  }



  static Future<int> insertContact(Contact contact) async {

    final db = await getDatabase();

    return await db.insert(
      'contacts',
      contact.toMap(),
    );
  }



  static Future<List<Contact>> getContacts() async {

    final db = await getDatabase();

    final List<Map<String, dynamic>> maps =
    await db.query(
      'contacts',
      orderBy: 'name ASC',
    );

    return maps.map((map) {
      return Contact.fromMap(map);
    }).toList();
  }


  static Future<int> updateContact(Contact contact) async {

    final db = await getDatabase();

    return await db.update(
      'contacts',
      contact.toMap(),
      where: 'id = ?',
      whereArgs: [contact.id],
    );
  }



  static Future<int> deleteContact(int id) async {

    final db = await getDatabase();

    return await db.delete(
      'contacts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }



  static Future<int> updateFavorite(
      int id,
      bool isFavorite,
      ) async {

    final db = await getDatabase();

    return await db.update(
      'contacts',
      {
        'isFavorite': isFavorite ? 1 : 0,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }



  static Future<void> deleteDatabaseFile() async {

    String databasePath = await getDatabasesPath();

    String path = join(
      databasePath,
      'contact_database.db',
    );

    await deleteDatabase(path);

    _database = null;
  }
}