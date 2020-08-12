import 'package:flutterfirebase/model/Note.dart';

import 'NoteDao.dart';

class NoteRepository {
  final noteDao = NoteDao();

  addNote(Note note) async => noteDao.addNote(note);

  Future<Note> getNoteById(int id) async => noteDao.getNoteById(id);

  Future<List<Note>> getNotes() async => noteDao.getNotes();

  update(Note note) async => noteDao.update(note);

  delete(Note note) async => noteDao.delete(note);

  deleteAllNotes() async => noteDao.deleteAllNotes();

}
