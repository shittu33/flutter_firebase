import 'package:flutterfirebase/NotePattern/NoteDao.dart';
import 'package:flutterfirebase/model/Note.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteDbHelper {
  static String tableName = "Note";
  static String columnId = "Id";
  static String columnAuthor = "Author";
  static String columnTitle = "title";
  static String columnDetail = "detail";

  SqliteDbHelper._();

  static SqliteDbHelper db = SqliteDbHelper._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    return await openDatabase(join(await getDatabasesPath(), "NoteDb.db"),
        onCreate: (db, version) async {
      await db.execute("Create Table $tableName ("
          " $columnId INTEGER PRIMARY KEY,"
          " $columnAuthor TEXT,"
          " $columnTitle TEXT,"
          " $columnDetail TEXT"
          ")");
      for (int i = 0; i <= 2; i++) {
        NoteDao().addNote(Note("my Note", "something", "shittu"));
      }
    }, version: 1);
  }

}
