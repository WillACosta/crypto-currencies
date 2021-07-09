import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// Garantimos que a classe seja um padrão singleton
class DB {
  // Construtor com acesso privado
  DB._();

  // Criar instancia de DB
  static final DB instance = DB._();

  // instancia do SQlite
  static Database? _database;

  get database async {
    if (_database != null) return _database;

    return await _initDatabase();
  }

  _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), "criptop.db"),
      version: 1,
      onCreate: _onCreate,
    );
  }

  _onCreate(db, version) async {
    await db.execute(_account);
    await db.execute(_wallet);
    await db.execute(_history);
    await db.insert("account", {"balance": 0});
  }

  String get _account => '''
    CREATE TABLE account (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      balance REAL
    )
  ''';

  String get _wallet => '''
    CREATE TABLE wallet (
      abbreviation TEXT PRIMARY KEY,
      currency TEXT,
      amount TEXT
    )
  ''';

  String get _history => '''
    CREATE TABLE history (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      operation_date INT,
      operation_type TEXT,
      currency TEXT,
      abbreviation TEXT,
      value REAL,
      amount TEXT
    )
  ''';
}
