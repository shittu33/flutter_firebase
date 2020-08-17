import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/main.dart';
import 'package:flutterfirebase/util/SqliteHelper.dart';
import 'NotePattern/NoteBloc.dart';
import 'NotePattern/NoteRepository.dart';

import 'customWidget/popUp.dart';
import 'model/Note.dart';
import 'noteScreen.dart';

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
                          onTap: () async {
                            dynamic noteResult = await Navigator.pushNamed(
                                context, MyApp.routeNoteScreen,
                                arguments: note.toScreenMap());
                            Note recNote = Note.fromScreenMap(noteResult);
                            recNote.id = note.id;
                            note.author = note.author;
                            if (noteResult[NoteScreen.ISDEl]) {
                              noteBloc.delete(recNote);
                            }else{
                              noteBloc.update(recNote);
                            }
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
        onPressed: () async {
          dynamic noteResult =
              await Navigator.pushNamed(context, MyApp.routeInput);
          noteBloc.addNote(Note.fromScreenMap(noteResult)
//              Note("Teba ti te bayi yoo mo delete ni?", "you", "xciv")
              );
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
      onButtonTap: (choice) async {
        Navigator.pop(context);
        switch (choice) {
          case "delete":
            showDialog(
                context: context,
                child: OptionAlertDialog(
                    title: "Do you want to delete me?",
                    onNegativeTap: () => Navigator.pop(context),
                    negativeTitle: "No",
                    onPositiveTap: () {
                      Navigator.pop(context);
                      return noteBloc.delete(note);
                    },
                    positiveTitle: "yes"));
            break;
          case "update":
            dynamic noteResult = await Navigator.pushNamed(
                context, MyApp.routeInput,
                arguments: note.toScreenMap());
            var receivedNote = Note.fromScreenMap(noteResult);
            receivedNote.id = note.id;
            noteBloc.update(receivedNote);
            break;
        }
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
