import 'package:flutterfirebase/util/SqliteHelper.dart';

class Note {
  int id;
  String title;
  String author;
  String details;

  Note(this.title, this.author, this.details);

  Note.full(this.id, this.title, this.author, this.details);

  Map<String, dynamic> toMap() => {
        SqliteDbHelper.columnId: id,
        SqliteDbHelper.columnAuthor: author,
        SqliteDbHelper.columnTitle: title,
        SqliteDbHelper.columnDetail: details
      };

  factory Note.fromMap(Map<String, dynamic> data) {
    return Note.full(
        data[SqliteDbHelper.columnId],
        data[SqliteDbHelper.columnTitle],
        data[SqliteDbHelper.columnAuthor],
        data[SqliteDbHelper.columnDetail]);
  }

  @override
  String toString() {
    return 'Note{id: $id, title: $title, author: $author, details: $details}';
  }
}
