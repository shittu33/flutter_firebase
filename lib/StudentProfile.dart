import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/NoteListWidget.dart';
import 'package:flutterfirebase/NotePattern/FirebaseNoteBloc.dart';
import 'package:flutterfirebase/main.dart';
import 'package:flutterfirebase/model/NoteFire.dart';
import 'package:flutterfirebase/model/Student.dart';

import 'customWidget/popUp.dart';

class StdProfileScreen extends StatefulWidget {
  @override
  _StdProfileScreenState createState() => _StdProfileScreenState();
}

class _StdProfileScreenState extends State<StdProfileScreen> {
  NoteBloc noteBloc = NoteBloc();

  @override
  Widget build(BuildContext context) {
//    final noteDocument = 'books';
    return Scaffold(
        appBar: AppBar(
          title: Text("Student Profiles"),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream:
              Firestore.instance.collection(Student.collectionName).snapshots(),
//          stream: noteBloc.notes,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return new Text('Loading...');
              default:
                return new ListView(
                  children:
                      snapshot.data.documents.map((DocumentSnapshot document) {
                    Student student;
                    if (document.data != null && document.data.isNotEmpty) {
                      student = Student.fromDocSnapShot(document);
                    }
                    var title = student.fullName;
                    var quote = student.quote;
                    var imgPath = student.imgPath;
                    return Card(
                      child: new ListTile(
                        onTap: () {},
                        leading: CircleAvatar(
//                          backgroundColor: Colors.black87,
                          child: Image.file(
                            File(imgPath!=null?imgPath:"null"),
                            errorBuilder: (context, exception, stackTrace) {
                              print(stackTrace);
                              return Text('😢');
                            },
                          ),
                        ),
                        title: new Text(student != null
                            ? (title != null ? title : "null")
                            : "empty"),
                        subtitle: new Text(student != null
                            ? (quote != null ? quote : "null")
                            : "empty"),
                        trailing: TextPopUpMenuButton(
                          list: ["update", "delete", "share"],
                          onButtonTap: (choice) async {
                            Navigator.pop(context);
                            switch (choice) {
                              case 'update':
                                dynamic result = await Navigator.pushNamed(
                                    context, MyApp.routeInput,
                                    arguments: document.data);
                                if (result.isNotEmpty) {
                                  document.reference.updateData(result);
                                }
                                break;
                              case 'delete':
                                showDialog(
                                    context: context,
                                    builder: (_) => new OptionAlertDialog(
                                          title: "are you sure?",
                                          positiveTitle: "yes",
                                          negativeTitle: "No",
                                          onPositiveTap: () {
                                            document.reference.delete();
                                            Navigator.pop(context);
                                          },
                                          onNegativeTap: () {
                                            Navigator.pop(context);
                                          },
                                        ));
                                break;
                            }
                          },
                        ),
                      ),
                    );
                  }).toList(),
                );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            dynamic result =
                await Navigator.pushNamed(context, MyApp.routeStdFormScreen);
            Firestore.instance
                .collection(Student.collectionName)
                .document()
                .setData(result);
          },
        ));
  }
}
