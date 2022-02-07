import 'package:dartz/dartz.dart';
import 'package:notes/features/notes/domain/repositories/note_repository.dart';

import '../../../../core/error/failures.dart';
import '../entities/note.dart';

class GetNote {
  final NoteRepository repository;

  GetNote({required this.repository});

  Future<Either<Failure, Note>> call({
    required String name,
  }) async {
    return await repository.getNote(name);
  }
}
