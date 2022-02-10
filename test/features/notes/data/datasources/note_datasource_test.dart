import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:notes/core/error/exceptions.dart';
import 'package:notes/features/notes/data/datasources/note_datasource.dart';
import 'package:notes/features/notes/data/models/note_model.dart';

import '../data_mock.mocks.dart';

void main() {
  late final MockHiveInterface mockHiveInterface;
  late final NoteDatasourceImpl noteDatasource;
  late final MockBox<NoteModel> mockBox;
  late final MockGetTimeInterfaceImpl mockGetTimeInterfaceImpl;
  const noteBoxName = "NoteBox";
  
  setUpAll(() {
    mockBox = MockBox<NoteModel>();
    mockHiveInterface = MockHiveInterface();
    mockGetTimeInterfaceImpl = MockGetTimeInterfaceImpl();
    noteDatasource = NoteDatasourceImpl(hiveInterface: mockHiveInterface, noteBoxName: noteBoxName, getTimeInterface: mockGetTimeInterfaceImpl);
  });

  const noteName = "note1";
  const newContent = "new test content";
  final dateNow = DateTime.utc(2018, 11, 9);
  final noteModel = NoteModel(name: noteName, content: "note content", creationDate: dateNow);
  final updatedNoteModel = NoteModel(name: noteName, content: newContent, creationDate: dateNow);
  final emptyNoteModel = NoteModel(name: noteName, content: "", creationDate: dateNow);

  group('hive CRUD operations successes', () {
    test('should get Note from Hive database', () async {
      when(mockHiveInterface.openBox(any)).thenAnswer((_) async => mockBox);
      when(mockBox.get(any)).thenAnswer((_) => noteModel);
      final result = await noteDatasource.getNote(noteName);
      expect(result, noteModel);
      verify(mockHiveInterface.openBox(noteBoxName));
      verify(mockBox.get(noteName));
    });
    test('should delete Note from Hive database', () async {
      when(mockHiveInterface.openBox(any)).thenAnswer((_) async => mockBox);
      when(mockBox.delete(any)).thenAnswer((_) async => Future.value());
      await noteDatasource.deleteNote(noteName);
      verify(mockHiveInterface.openBox(noteBoxName));
      verify(mockBox.delete(noteName));
    });
    test('should update Note in Hive database', () async {
      when(mockHiveInterface.openBox(any)).thenAnswer((_) async => mockBox);
      when(mockBox.get(any)).thenAnswer((_) => noteModel);
      when(mockBox.put(any, any)).thenAnswer((_) async => Future.value());
      await noteDatasource.updateNote(noteName, newContent);
      verify(mockHiveInterface.openBox(noteBoxName));
      verify(mockBox.get(noteName));
      verify(mockBox.put(noteName, updatedNoteModel));
    });
    test('should create Note in Hive database', () async {
      when(mockHiveInterface.openBox(any)).thenAnswer((_) async => mockBox);
      when(mockBox.put(any, any)).thenAnswer((_) async => Future.value());
      when(mockGetTimeInterfaceImpl.now()).thenReturn(dateNow);
      when(mockBox.get(any)).thenAnswer((_) => null);
      await noteDatasource.createNote(noteName);
      verify(mockHiveInterface.openBox(noteBoxName));
      verify(mockBox.put(noteName, emptyNoteModel));
      verify(mockGetTimeInterfaceImpl.now());
      verify(mockBox.get(noteName));
    });
  });
  group('hive CRUD operations failures', () {
    test('getNote should throw HiveException when there is no note with given name', () async {
      when(mockHiveInterface.openBox(any)).thenAnswer((_) async => mockBox);
      when(mockBox.get(any)).thenAnswer((_) => null);
      expect(() => noteDatasource.getNote(noteName), throwsA(isA<HiveException>()));
      verify(mockHiveInterface.openBox(noteBoxName));
    });
    test('createNote should throw HiveException if there is note with given name already', () async {
      when(mockHiveInterface.openBox(any)).thenAnswer((_) async => mockBox);
      when(mockBox.get(any)).thenAnswer((_) => noteModel);
      expect(() => noteDatasource.createNote(noteName), throwsA(isA<HiveException>()));
      verify(mockHiveInterface.openBox(noteBoxName));
      verify(mockBox.get(noteName));
    });
  });
}