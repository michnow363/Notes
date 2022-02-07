import 'package:dartz/dartz.dart';
import 'package:notes/core/error/failures.dart';
import 'package:notes/features/notes/domain/entities/note.dart';

abstract class NoteRepository {
  Future<Either<Failure, Note>> getNote(String name);
}