import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sicovid/models/user.dart';
import 'package:sqflite/sqflite.dart';

// classe de manipulação do banco de dados
class DatabaseHelper {
  final String databaseName = "sicovid.db"; //  nome da base
  final int databaseVersion = 1;

  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database _db;

  // inicializa o banco de dados
  initDb() async {
    Directory docDir = await getApplicationDocumentsDirectory();
    String path = join(docDir.path, databaseName);
    var db =
        await openDatabase(path, version: databaseVersion, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE user(id INTEGER PRIMARY KEY autoincrement, name TEXT, email TEXT, phone TEXT, password TEXT, photo TEXT)");
  }

  // método singleton em si
  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  // método para registrar um usuário
  Future<int> saveUser(User u) async {
    var dbClient = await db;
    int res = await dbClient.insert("user", u.toMap());
    return res;
  }

  // método para atualizar dados do usuário
  Future<bool> updateUser(User u) async {
    var dbClient = await db;
    int res = await dbClient
        .update("user", u.toMap(), where: "id = ?", whereArgs: [u.id]);
    return res > 0 ? true : false;
  }

  // método para excluir dados do usuário
  Future<bool> deleteUser(User u) async {
    var dbClient = await db;
    int res = await dbClient.rawDelete("DELETE FROM user WHERE id = ?", [u.id]);
    return res > 0 ? true : false;
  }

  Future<User> validateLogin(String email, String password) async {
    var dbClient = await db;
    User user;
    List<Map> list = await dbClient.rawQuery(
        "SELECT * FROM user WHERE email = ? AND password = ?",
        [email, password]);
    if (list != null && list.length > 0) {
      user = User(list[0]["id"], list[0]["name"], list[0]["email"],
          list[0]["phone"], list[0]["password"], list[0]["photo"]);
    }
    return user;
  }

  Future<User> emailCadastrado(String email) async {
    var dbClient = await db;
    User user;
    List<Map> list =
        await dbClient.rawQuery("SELECT * FROM user WHERE email = ?", [email]);
    if (list != null && list.length > 0) {
      user = User(list[0]["id"], list[0]["name"], list[0]["email"],
          list[0]["phone"], list[0]["password"], list[0]["photo"]);
    }
    return user;
  }
}
