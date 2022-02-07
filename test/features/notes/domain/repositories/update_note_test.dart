import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:notes/core/error/successes.dart';
import 'package:notes/features/notes/domain/usecases/update_note.dart';

import '../mocks.mocks.dart';

void main() {
  late UpdateNote useCase;
  late MockNoteRepository mockNoteRepository;

  setUp(() {
    mockNoteRepository = MockNoteRepository();
    useCase = UpdateNote(repository: mockNoteRepository);
  });

  const noteName = "note1";
  const newContent = "new test content";
  final updateSuccess = UpdateSuccess();

  test(
    "should update note for given name in repository",
        () async {
      when(mockNoteRepository.updateNote(noteName, newContent)).thenAnswer((_) async => Right(updateSuccess));
      final result = await useCase(const Params(name: noteName, newContent: newContent));

      expect(result, Right(updateSuccess));
      verify(mockNoteRepository.updateNote(noteName, newContent));
      verifyNoMoreInteractions(mockNoteRepository);
    },
  );
}