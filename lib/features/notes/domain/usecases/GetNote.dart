import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:notes/core/usecases/usecases.dart';
import 'package:notes/features/notes/domain/repositories/note_repository.dart';

import '../../../../core/error/failures.dart';
import '../entities/note.dart';

class GetNote implements UseCase<Note, Params>{
  final NoteRepository repository;

  GetNote({required this.repository});

  @override
  Future<Either<Failure, Note>> call(Params params) {
    return repository.getNote(params.name);
  }
}

class Params extends Equatable {
  final String name;

  const Params({required this.name});

  @override
  List<Object?> get props => throw UnimplementedError();
}