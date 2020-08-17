import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterfirebase/main.dart';
import 'package:flutterfirebase/model/NoteFire.dart';

import 'customWidget/popUp.dart';

class NoteScreen extends StatefulWidget {
  static const ISDEl = "isDelete";

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  var detailControl = TextEditingController();
  String _title = "Note Details";
  String _details = "Some text goes here ";
  bool _isFirst = true;

  _NoteScreenState() {
    for (int i = 0; i < 80; i++) _details += "Some text goes here ";
  }

  updateTitle(String txt) {
    setState(() {
      _isFirst = false;
      _title = txt;
    });
  }

  updateDetails(String txt) {
    setState(() {
      _isFirst = false;
      _details = txt;
    });
  }

  @override
  Widget build(BuildContext context) {
    var receivedData = ModalRoute.of(context).settings.arguments;
    NoteFire note = NoteFire.fromMap(receivedData);
    if (_isFirst &&
        note != null &&
        note.details != null &&
        note.title != null) {
      _details = note.details;
      _title = note.title;
    }
    Function() onBackPressed = () {
      Navigator.pop(context, {
        NoteFire.fieldDetail: detailControl.text,
        NoteFire.fieldTitle: detailControl.text,
        NoteScreen.ISDEl: false
//                NoteFire.fieldAuthor: authorController.text
      });
    };
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        leading: GestureDetector(
            onTap: onBackPressed, child: Icon(Icons.arrow_back)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                GestureDetector(onTap: onBackPressed, child: Icon(Icons.save)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
//            child: GestureDetector(
//                onTap: () {
//                  Navigator.of(context, rootNavigator: false).pop({
//                    NoteFire.fieldDetail: detailControl.text,
//                    NoteFire.fieldTitle: detailControl.text,
//                    NoteScreen.ISDEl: true
//                  });
//                },
//                child: Icon(Icons.delete)),
            child: TextPopUpMenuButton(
              list: ["delete"],
              onButtonTap: (choice) {
                Navigator.pop(context);
                sleep(Duration(seconds: 10));
                Navigator.of(context, rootNavigator: true).pop({
                  NoteFire.fieldDetail: detailControl.text,
                  NoteFire.fieldTitle: detailControl.text,
                  NoteScreen.ISDEl: true
                });
              },
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              maxLines: 100,

              minLines: 2,

//              expands: true,
              controller:
                  _isFirst ? (detailControl..text = _details) : detailControl,
            ),
          )
        ],
      ),
    );
  }
}
