import 'dart:async';

import 'package:flutterfirebase/model/Note.dart';

import 'NoteRepository.dart';

class NoteBloc {
  final noteRepo = NoteRepository();
  final noteController = StreamController<List<Note>>.broadcast();

  get notes => noteController.stream;

  NoteBloc() {
    getNotes();
  }

  dispose() {
    noteController.close();
  }

  addNote(Note note) async {
    await noteRepo.addNote(note);
    getNotes();
  }

  getNotes() async {
    noteController.sink.add(await noteRepo.getNotes());
  }

  deleteAllNotes() async {
    await noteRepo.deleteAllNotes();
    getNotes();
  }

  delete(Note note) async {
    await noteRepo.delete(note);
    getNotes();
  }

  update(Note note) async {
    await noteRepo.update(note);
    getNotes();
  }

  Future<Note> getNoteById(int id) {
    return noteRepo.getNoteById(id);
  }
}
