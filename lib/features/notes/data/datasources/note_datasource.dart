import 'package:hive/hive.dart';
import 'package:notes/core/error/exceptions.dart';

import '../../../../core/GetTimeInterface.dart';
import '../models/note_model.dart';

abstract class NoteDatasource {
  Future<void> createNote(String name);
  Future<void> deleteNote(String name);
  Future<NoteModel> getNote(String name);
  Future<void> updateNote(String name, String content);
}

class NoteDatasourceImpl implements NoteDatasource {
  NoteDatasourceImpl({required this.hiveInterface, required this.noteBoxName, required this.getTimeInterface});
  final HiveInterface hiveInterface;
  final String noteBoxName;
  final GetTimeInterfaceImpl getTimeInterface;

  @override
  Future<void> createNote(String name) async {
    final Box<NoteModel> box = await hiveInterface.openBox<NoteModel>(noteBoxName);
    NoteModel? noteModel = box.get(name);
    if(noteModel != null) {
      throw HiveException();
    } else {
      final noteModel = NoteModel(name: name, content: "", creationDate: getTimeInterface.now());
      return box.put(name, noteModel);
    }
  }

  @override
  Future<void> deleteNote(String name) async {
    final Box<NoteModel> box = await hiveInterface.openBox<NoteModel>(noteBoxName);
    return box.delete(name);
  }

  @override
  Future<NoteModel> getNote(String name) async {
    final Box<NoteModel> box = await hiveInterface.openBox<NoteModel>(noteBoxName);
    NoteModel? noteModel = box.get(name);
    if(noteModel == null) {
      throw HiveException();
    } else {
      return noteModel;
    }
  }

  @override
  Future<void> updateNote(String name, String content) async {
    final Box<NoteModel> box = await hiveInterface.openBox<NoteModel>(noteBoxName);
    NoteModel? noteModel = box.get(name);
    if(noteModel == null) {
      throw HiveException();
    } else {
      noteModel.content = content;
      return box.put(name, noteModel);
    }
  }
}