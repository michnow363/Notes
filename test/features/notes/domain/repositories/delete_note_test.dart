import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:notes/core/error/successes.dart';
import 'package:notes/features/notes/domain/repositories/note_repository.dart';
import 'package:notes/features/notes/domain/usecases/DeleteNote.dart';

import 'note_repository_test.mocks.dart';

@GenerateMocks([NoteRepository])
void main() {
  late DeleteNote useCase;
  late MockNoteRepository mockNoteRepository;

  setUp(() {
    mockNoteRepository = MockNoteRepository();
    useCase = DeleteNote(repository: mockNoteRepository);
  });

  const noteName = "note1";
  final deleteSuccess = DeleteSuccess();

  test(
    "should get note for given name from repository",
        () async {
      when(mockNoteRepository.deleteNote(noteName)).thenAnswer((_) async => Right(deleteSuccess));
      final result = await useCase(const Params(name: noteName));

      expect(result, Right(deleteSuccess));
      verify(mockNoteRepository.deleteNote(noteName));
      verifyNoMoreInteractions(mockNoteRepository);
    },
  );
}
