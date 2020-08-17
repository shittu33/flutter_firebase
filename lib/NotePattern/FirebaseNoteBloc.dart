import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterfirebase/model/NoteFire.dart';

import 'NoteRepository.dart';

class NoteBloc {
//  final noteRepo = NoteRepository();
//  final noteController = StreamController<List<Note>>.broadcast();

  get notes => getNotes();

//  NoteBloc() {
//    getNotes();
//  }
//
//  dispose() {
//    noteController.close();
//  }
//
//  addNote(Note note) async {
//    await noteRepo.addNote(note);
//    getNotes();
//  }

  getNotes() async {
    return Firestore.instance
        .collection(NoteFire.collectionName)
        .snapshots()
        .map((QuerySnapshot map) {
      return map.documents.map((DocumentSnapshot document) {
        NoteFire.fromDocSnapShot(document);
      });
    });
//    noteController.sink.add(await noteRepo.getNotes());
  }

//  deleteAllNotes() async {
//    await noteRepo.deleteAllNotes();
//    getNotes();
//  }
//
//  delete(Note note) async {
//    await noteRepo.delete(note);
//    getNotes();
//  }
//
//  update(Note note) async {
//    await noteRepo.update(note);
//    getNotes();
//  }
//
//  Future<Note> getNoteById(int id) {
//    return noteRepo.getNoteById(id);
//  }
}
