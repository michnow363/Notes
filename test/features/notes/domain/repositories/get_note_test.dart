import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:notes/features/notes/domain/entities/note.dart';
import 'package:notes/features/notes/domain/usecases/get_note.dart';

import '../domain_mock.mocks.dart';

void main() {
  late GetNote useCase;
  late final MockNoteRepository mockNoteRepository;

  setUpAll(() {
    mockNoteRepository = MockNoteRepository();
    useCase = GetNote(repository: mockNoteRepository);
  });

  const noteName = "note1";
  final note = Note(
    name: "note1",
    content: "test note",
    creationDate: DateTime.utc(2018, 11, 9),
  );

  test(
    "should get note for given name from repository",
        () async {
      when(mockNoteRepository.getNote(any)).thenAnswer((_) async => Right(note));
      final result = await useCase(const Params(name: noteName));

      expect(result, Right(note));
      verify(mockNoteRepository.getNote(noteName));
      verifyNoMoreInteractions(mockNoteRepository);
    },
  );
}
