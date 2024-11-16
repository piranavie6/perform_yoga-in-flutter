import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper2 {
  static final DatabaseHelper2 _instance = DatabaseHelper2._internal();

  factory DatabaseHelper2() => _instance;

  DatabaseHelper2._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'db_yoga.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE user (
            id INTEGER PRIMARY KEY,
            email TEXT,
            password TEXT
          )
        ''');

        // Example user data
        await db.insert('user', {'email': 'helena.hills@gmail.com', 'password': 'password123'});
      },
    );
  }

  Future<Map<String, dynamic>> fetchUserDetails() async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query('user');
    if (result.isNotEmpty) {
      return result.first;  // Assuming there is only one user
    } else {
      throw Exception("User not found.");
    }
  }
}
