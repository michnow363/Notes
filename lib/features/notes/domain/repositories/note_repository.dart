import 'package:dartz/dartz.dart';
import 'package:notes/core/error/failures.dart';
import 'package:notes/features/notes/domain/entities/note.dart';

import '../../../../core/error/successes.dart';

abstract class NoteRepository {
  Future<Either<Failure, Note>> getNote(String name);
  Future<Either<Failure, Success>> updateNote(String name, String content);
  Future<Either<Failure, Success>> createNote(String name);
  Future<Either<Failure, Success>> deleteNote(String name);
}