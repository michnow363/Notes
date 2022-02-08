import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:notes/features/notes/domain/usecases/create_note.dart';

import '../domain_mock.mocks.dart';

void main() {
  late CreateNote useCase;
  late final MockNoteRepository mockNoteRepository;

  setUpAll(() {
    mockNoteRepository = MockNoteRepository();
    useCase = CreateNote(repository: mockNoteRepository);
  });

  const noteName = "note1";

  test(
    "should delete note for given name from repository",
        () async {
      when(mockNoteRepository.createNote(any)).thenAnswer((_) async => Right(null));
      final result = await useCase(const Params(name: noteName));

      expect(result, Right(null));
      verify(mockNoteRepository.createNote(noteName));
      verifyNoMoreInteractions(mockNoteRepository);
    },
  );
}