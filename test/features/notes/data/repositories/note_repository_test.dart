import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:notes/core/error/exceptions.dart';
import 'package:notes/core/error/failures.dart';
import 'package:notes/features/notes/data/models/note_model.dart';
import 'package:notes/features/notes/data/repositories/note_repository_impl.dart';

import '../data_mock.mocks.dart';

void main() {
  late final MockNoteDatasource mockNoteDatasource;
  late final NoteRepositoryImpl noteRepositoryImpl;
  setUpAll(() {
    mockNoteDatasource = MockNoteDatasource();
    noteRepositoryImpl = NoteRepositoryImpl(noteDatasource: mockNoteDatasource);
  });

  const noteName = "note1";
  const newContent = "new test content";
  final noteModel = NoteModel(name: 'note1', content: 'test content', date: DateTime.utc(2018, 11, 9));

  test('should get Note from database', () async {
    when(mockNoteDatasource.getNote(any)).thenAnswer((_) async => noteModel);
    final result = await noteRepositoryImpl.getNote(noteName);
    expect(result, Right(noteModel));
    verify(mockNoteDatasource.getNote(noteName));
    verifyNoMoreInteractions(mockNoteDatasource);
  });
  test('should create Note in database', () {
    when(mockNoteDatasource.createNote(any)).thenAnswer((_) async => null);
    noteRepositoryImpl.createNote(noteName);
    verify(mockNoteDatasource.createNote(noteName));
    verifyNoMoreInteractions(mockNoteDatasource);
  });
  test('should delete Note from database', () {
    when(mockNoteDatasource.deleteNote(any)).thenAnswer((_) async => null);
    noteRepositoryImpl.deleteNote(noteName);
    verify(mockNoteDatasource.deleteNote(noteName));
    verifyNoMoreInteractions(mockNoteDatasource);
  });
  test('should update Note in database', () {
    when(mockNoteDatasource.updateNote(any, any)).thenAnswer((_) async => null);
    noteRepositoryImpl.updateNote(noteName, newContent);
    verify(mockNoteDatasource.updateNote(noteName, newContent));
    verifyNoMoreInteractions(mockNoteDatasource);
  });
  test('should get GetException from database if there  is no file with given name', () async {
    when(mockNoteDatasource.getNote(any)).thenThrow(HiveException());
    final result = await noteRepositoryImpl.getNote(noteName);
    expect(result, Left(GetNoteFailure()));
    verify(mockNoteDatasource.getNote(noteName));
    verifyNoMoreInteractions(mockNoteDatasource);
  });
}