import '../models/note_model.dart';

abstract class NoteDatasource {
  Future<void> createNote(String name);
  Future<void> deleteNote(String name);
  Future<NoteModel> getNote(String name);
  Future<void> updateNote(String name, String content);
}