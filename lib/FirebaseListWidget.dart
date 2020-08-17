import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/NoteListWidget.dart';
import 'package:flutterfirebase/NotePattern/FirebaseNoteBloc.dart';
import 'package:flutterfirebase/main.dart';
import 'package:flutterfirebase/model/NoteFire.dart';

import 'customWidget/popUp.dart';

class FirebaseListWidget extends StatefulWidget {
  @override
  _FirebaseListWidgetState createState() => _FirebaseListWidgetState();
}

class _FirebaseListWidgetState extends State<FirebaseListWidget> {
  NoteBloc noteBloc = NoteBloc();

  @override
  Widget build(BuildContext context) {
//    final noteDocument = 'books';
    return Scaffold(
        appBar: AppBar(
          title: Text("FireBase"),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream:
          Firestore.instance.collection(NoteFire.collectionName).snapshots(),
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
                    NoteFire note;
                    if (document.data != null && document.data.isNotEmpty) {
                      note = NoteFire.fromDocSnapShot(document);
                    }
                    var title = note.title;
                    var details = note.details;
                    return Card(
                      child: new ListTile(
                        onTap: () {},
                        leading: CircleAvatar(
                          child: Icon(Icons.text_fields),
                        ),
                        title: new Text(note != null
                            ? (title != null ? title : "null")
                            : "empty"),
                        subtitle: new Text(note != null
                            ? (details != null ? details : "null")
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
            await Navigator.pushNamed(context, MyApp.routeInput);
            Firestore.instance
                .collection(NoteFire.collectionName)
                .document()
                .setData(result);
          },
        ));
  }
}
