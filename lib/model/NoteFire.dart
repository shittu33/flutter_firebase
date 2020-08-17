import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterfirebase/util/SqliteHelper.dart';

class NoteFire {
  static String collectionName = "books";
  static String fieldAuthor = "Author";
  static String fieldTitle = "tittle";
  static String fieldDetail = "detail";
  String title;
  String author;
  String details;

  NoteFire(this.title, this.author, this.details);

  NoteFire.full(this.title, this.author, this.details);

  Map<String, dynamic> toMap() => {
        fieldAuthor: author,
        fieldTitle: title,
        fieldDetail: details
      };

  factory NoteFire.fromMap(Map<String, dynamic> data) {
    if(data.isEmpty){
      return null;
    }
    return NoteFire.full(
        data[fieldTitle],
        data[fieldAuthor],
        data[fieldDetail]);
  }

  factory NoteFire.fromDocSnapShot(DocumentSnapshot snapshot) {
    if(snapshot.data.isEmpty){
      return null;
    }
    return NoteFire.full(
        snapshot[fieldTitle],
        snapshot[fieldAuthor],
        snapshot[fieldDetail]);
  }

  @override
  String toString() {
    return 'Note{title: $title, author: $author, details: $details}';
  }
}
