import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:notes/features/notes/domain/usecases/update_note.dart';

import '../domain_mock.mocks.dart';

void main() {
  late UpdateNote useCase;
  late final MockNoteRepository mockNoteRepository;

  setUpAll(() {
    mockNoteRepository = MockNoteRepository();
    useCase = UpdateNote(repository: mockNoteRepository);
  });

  const noteName = "note1";
  const newContent = "new test content";
  test(
    "should update note for given name in repository",
        () async {
      when(mockNoteRepository.updateNote(any, any)).thenAnswer((_) async => Right(null));
      final result = await useCase(const Params(name: noteName, newContent: newContent));

      expect(result, Right(null));
      verify(mockNoteRepository.updateNote(noteName, newContent));
      verifyNoMoreInteractions(mockNoteRepository);
    },
  );
}