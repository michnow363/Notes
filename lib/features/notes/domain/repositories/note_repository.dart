import 'package:dartz/dartz.dart';
import 'package:notes/core/error/failures.dart';
import 'package:notes/features/notes/domain/entities/note.dart';

abstract class NoteRepository {
  Future<Either<Failure, Note>> getNote(String name);
  Future<Either<Failure, void>> updateNote(String name, String content);
  Future<Either<Failure, void>> createNote(String name);
  Future<Either<Failure, void>> deleteNote(String name);
}