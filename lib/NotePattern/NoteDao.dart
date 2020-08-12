
import 'package:flutterfirebase/model/Note.dart';
import 'package:flutterfirebase/util/SqliteHelper.dart';

class NoteDao {
  SqliteDbHelper dbHelper = SqliteDbHelper.db;

  addNote(Note note) async {
    final db = await dbHelper.database;
    await db.insert(SqliteDbHelper.tableName, {
      SqliteDbHelper.columnTitle: note.title,
      SqliteDbHelper.columnDetail: note.details,
      SqliteDbHelper.columnAuthor: note.author
    });
  }

  update(Note note) async {
    final db = await dbHelper.database;
    return await db.update(SqliteDbHelper.tableName, note.toMap(),
        where: "${SqliteDbHelper.columnId} = ${note.id}");
  }

  delete(Note note) async {
    final db = await dbHelper.database;
    return await db.delete(SqliteDbHelper.tableName,
        where: '${SqliteDbHelper.columnId} = ?', whereArgs: [note.id]);
  }

  deleteAllNotes() async {
    final db = await dbHelper.database;
    return await db.delete(SqliteDbHelper.tableName);
  }

  Future<Note> getNoteById(int id) async {
    final db = await dbHelper.database;
    var result = await db.query(SqliteDbHelper.tableName,
        where: "WHERE $SqliteDbHelper.columnId= $id");
    return result.isNotEmpty ? Note.fromMap(result.first) : Null;
  }

  Future<List<Note>> getNotes() async {
    print("before db--------->");
    final db = await dbHelper.database;
    print("before --------->");
    var result = await db
        .query(SqliteDbHelper.tableName /*, orderBy: "$columnTitle ASC" */);
    return result.isNotEmpty
        ? result.map((noteMap) {
            print(Note.fromMap(noteMap));
            return Note.fromMap(noteMap);
          }).toList()
        : [];
  }
}
