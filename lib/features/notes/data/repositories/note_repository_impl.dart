import 'package:dartz/dartz.dart';
import 'package:notes/core/error/failures.dart';
import 'package:notes/features/notes/data/datasources/note_datasource.dart';
import 'package:notes/features/notes/domain/repositories/note_repository.dart';

import '../../domain/entities/note.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteDatasource noteDatasource;
  NoteRepositoryImpl({required this.noteDatasource});

  @override
  Future<Either<Failure, void>> createNote(String name) async {
    return Right(noteDatasource.createNote(name));
  }

  @override
  Future<Either<Failure, void>> deleteNote(String name) async {
    return Right(noteDatasource.deleteNote(name));
  }

  @override
  Future<Either<Failure, Note>> getNote(String name) async {
    return Right(await noteDatasource.getNote(name));
  }

  @override
  Future<Either<Failure, void>> updateNote(String name, String content) async {
    return Right(noteDatasource.updateNote(name, content));
  }
}