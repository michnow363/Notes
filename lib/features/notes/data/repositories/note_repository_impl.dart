import 'package:dartz/dartz.dart';
import 'package:notes/core/error/exceptions.dart';
import 'package:notes/core/error/failures.dart';
import 'package:notes/features/notes/data/datasources/note_datasource.dart';
import 'package:notes/features/notes/domain/repositories/note_repository.dart';

import '../../domain/entities/note.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteDatasource noteDatasource;
  NoteRepositoryImpl({required this.noteDatasource});

  @override
  Future<Either<Failure, void>> createNote(String name) async {
    try{
      return Right(noteDatasource.createNote(name));
    } on HiveException {
      return Left(CreateNoteFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteNote(String name) async {
    try{
      return Right(noteDatasource.deleteNote(name));
    } on HiveException {
      return Left(DeleteNoteFailure());
    }
  }

  @override
  Future<Either<Failure, Note>> getNote(String name) async {
    try {
      return Right(await noteDatasource.getNote(name));
    } on HiveException {
      return Left(GetNoteFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateNote(String name, String content) async {
    try{
      return Right(noteDatasource.updateNote(name, content));
    } on HiveException {
      return Left(UpdateNoteFailure());
    }
  }
}