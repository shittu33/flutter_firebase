import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterfirebase/util/SqliteHelper.dart';

class Student {
  static String collectionName = "Students";
  static String fieldName = "name";
  static String fieldNickName = "Nick name";
  static String fieldAge = "age";
  static String fieldDept = "department";
  static String fieldLevel = "level";
  static String fieldHobby = "hobby";
  static String fieldImg = "department";
  static String fieldQuote = "Quote";
  @required
  String fullName;
  String nickName = "Ajax";
  String dept = "Computer Science";
  String imgPath = "";
  String level = "300L";
  String hobby = "Football";
  String quote = "Life is full of pain, but there is no gain without pain";
  int age = 20;

  Student.simple(this.fullName, this.imgPath);

  Student({@required this.fullName,
    this.nickName,
    this.dept,
    this.imgPath,
    this.level,
    this.hobby,
    this.quote,
    this.age});

  Student.full(this.fullName, this.nickName, this.dept, this.imgPath,
      this.level, this.hobby, this.quote, this.age);

  Student.essential(this.fullName, this.dept, this.imgPath, this.level,
      this.age);

  Map<String, dynamic> toMap() =>
      {
        fieldName: fullName,
        fieldNickName: nickName,
        fieldDept: dept,
        fieldImg: imgPath,
        fieldLevel: level,
        fieldHobby: hobby,
        fieldQuote: quote,
        fieldAge: age
      };

  factory Student.fromMap(Map<String, dynamic> data) {
    if (data.isEmpty) {
      return null;
    }
    return Student.full(
      data[fieldName],
      data[fieldNickName],
      data[fieldDept],
      data[fieldImg],
      data[fieldLevel],
      data[fieldHobby],
      data[fieldQuote],
      data[fieldAge],
    );
  }

  factory Student.fromDocSnapShot(DocumentSnapshot snapshot) {
    if (snapshot.data.isEmpty) {
      return null;
    }
    return Student.full(
      snapshot[fieldName],
      snapshot[fieldNickName],
      snapshot[fieldDept],
      snapshot[fieldImg],
      snapshot[fieldLevel],
      snapshot[fieldHobby],
      snapshot[fieldQuote],
      snapshot[fieldAge],
    );
  }
}