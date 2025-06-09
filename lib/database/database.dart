import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper
{
  static final DatabaseHelper instance = DatabaseHelper.internal();
  Database? internal;

  factory DatabaseHelper()
  {
    return instance;
  }

  DatabaseHelper.internal();

  Future<Database?> get database async
  {
    if(internal != null)
    {
      return internal;
    }
    internal = await startDatabase();
    return internal;
  }

  Future<Database> startDatabase() async
  {
    return openDatabase(
      join(await getDatabasesPath(), 'users_database.db'),
      onCreate: (db, version)
      {
        return db.execute(
          "CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, email TEXT, password TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<void> addUser(String name, String email, String password) async
  {
    final db = await database;
    await db!.insert(
      'users',
      {'name': name, 'email': email, 'password': password},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> getUser(String email) async
  {
    final db = await database;
    final List<Map<String, dynamic>> users = await db!.query(
      'users',
      where: "email = ?",
      whereArgs: [email],
    );
    if(users.isNotEmpty)
    {
      return users.first;
    }
    return null;
  }

  Future<List<Map<String, dynamic>>> getUsers() async
  {
    final db = await database;
    return await db!.query('users');
  }
}