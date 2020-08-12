import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/util/SqliteHelper.dart';
import 'NotePattern/NoteBloc.dart';
import 'NotePattern/NoteRepository.dart';

import 'model/Note.dart';

class NoteWidget extends StatefulWidget {
  SqliteDbHelper db;

  @override
  _NoteBlocWidgetState createState() => _NoteBlocWidgetState();

  NoteWidget() {
    db = SqliteDbHelper.db;
  }
}

class _NoteBlocWidgetState extends State<NoteWidget> {
//  final SqliteDbHelper db;
  final noteBloc = NoteBloc();

//  NoteBloc noteBloc;

  _NoteBlocWidgetState();

  @override
  void dispose() {
    noteBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          TextPopUpMenuButton(
              list: ["okay"],
              onButtonTap: (choice) {
                print("I am fine!!!");
              })
        ],
        title: Text("Sqlite Sample"),
//        child: TabBar(tabs: <Widget>[Text("okay")],
      ),
//      ),
      body: StreamBuilder<List<Note>>(
          stream: noteBloc.notes,
          builder: ((context, AsyncSnapshot<List<Note>> snapshot) {
            if (snapshot.hasData) {
              var notes = snapshot.data;
              return ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (context, position) {
                    Note note = notes[position];
                    return Card(
                      child: ListTile(
                          onTap: () {
                            noteBloc.delete(note);
                          },
                          trailing:
                              NotePopUpOption(note: note, noteBloc: noteBloc),
                          leading: CircleAvatar(),
                          title: Text(note.title)),
                    );
                  });
            } else {
              return Text(
                "Empty",
                style: TextStyle(fontSize: 23),
              );
            }
          })),
//        ],
//      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
//          noteBloc.deleteAllNotes();
          noteBloc.addNote(
              Note("Teba ti te bayi yoo mo delete ni?", "you", "xciv"));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class NotePopUpOption extends StatelessWidget {
  const NotePopUpOption({
    Key key,
    @required this.note,
    @required this.noteBloc,
  }) : super(key: key);

  final Note note;
  final NoteBloc noteBloc;

  @override
  Widget build(BuildContext context) {
    List list = ["delete", "update", "remove"];
    return TextPopUpMenuButton(
      list: list,
      onButtonTap: (choice) {
        switch (choice) {
          case "delete":
            showDialog(
                context: context,
                child: OptionAlertDialog(
                    title: "Do you want to delete me?",
                    onNegativeTap: () => print("onNegativeTap"),
                    negativeTitle: "No",
                    onPositiveTap: () => noteBloc.delete(note),
                    positiveTitle: "yes"));
            break;
          case "update":
            note.title = "Hummm? kilowi Abdul sabur";
            note.author = "me";
            note.details = "Something Good is going to happen in my Life";
            noteBloc.update(note);
            break;
        }
      },
    );
  }
}

class OptionAlertDialog extends StatelessWidget {
  const OptionAlertDialog({
    Key key,
    @required this.title,
    this.onNegativeTap,
    this.negativeTitle,
    this.onPositiveTap,
    this.positiveTitle,
  }) : super(key: key);

  final String title;
  final Function() onNegativeTap;
  final String negativeTitle;
  final Function() onPositiveTap;
  final String positiveTitle;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        actionsPadding: EdgeInsets.all(0),
        title: Text(title),
        actions: <Widget>[
          negativeTitle != null
              ? FlatButton(
                  onPressed: onNegativeTap,
                  child: Text(negativeTitle),
                )
              : null,
          positiveTitle != null
              ? FlatButton(
                  onPressed: onPositiveTap,
                  child: Text(positiveTitle),
                )
              : null,
        ]);
  }
}

class TextPopUpMenuButton extends StatelessWidget {
  TextPopUpMenuButton({
    Key key,
    @required this.list,
    this.icon,
    @required this.onButtonTap,
  }) : super(key: key);

  final IconData icon;
  final List list;
  final Function(String choice) onButtonTap;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: icon != null ? Icon(icon) : Icon(Icons.more_vert),
      itemBuilder: (BuildContext context) {
        return list
            .map((choice) => PopupMenuItem(
                child: GestureDetector(
//                  onTap: (){
//                    print("clicked!!!");
//                  },
                    onTap: onButtonTap(choice),
                    child: Text(choice))))
            .toList();
      },
    );
  }
}

class _NoteFutureWidgetState extends State<NoteWidget> {
  final NoteRepository noteRepo;

  _NoteFutureWidgetState(this.noteRepo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sqlite Sample"),
      ),
      body:
          /*Column(
        children: <Widget>[TabBar(
            tabs: [
              Text("tab1"),
              Text("tab2"),
              Text("tab3"),
              Text("tab4"),
            ]
        ),*/
          FutureBuilder<List<Note>>(
              future: noteRepo.getNotes(),
              builder: ((context, AsyncSnapshot<List<Note>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, position) {
                        Note note = snapshot.data[position];
                        return ListTile(title: Text(note.title));
                      });
                } else {
                  return Text(
                    "Empty",
                    style: TextStyle(fontSize: 23),
                  );
                }
              })),
//        ],
//      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          noteRepo.addNote(Note("me", "you", "xkjckvh"));
          setState(() {});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
