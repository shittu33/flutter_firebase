import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/main.dart';

class FirebaseListWidget extends StatefulWidget {
  @override
  _FirebaseListWidgetState createState() => _FirebaseListWidgetState();
}

class _FirebaseListWidgetState extends State<FirebaseListWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("FireBase"),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('books').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return new Text('Loading...');
              default:
                return new ListView(
                  children: snapshot.data.documents
                      .map((DocumentSnapshot document) => new ListTile(
                            title: new Text(document['title']),
                            subtitle: new Text(document['author']),
                          ))
                      .toList(),
                );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            dynamic result = await Navigator.pushNamed(context, MyApp.routeInput);
//            Map noteArg = ModalRoute.of(context).settings.arguments;
            Firestore.instance
                .collection('books')
                .document()
                .setData({'title': result['tittle'], 'author': result['author']});
          },
        ));
  }
}
