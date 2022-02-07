import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/error/successes.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/note_repository.dart';

class DeleteNote implements UseCase<Success, Params>{
  final NoteRepository repository;

  DeleteNote({required this.repository});

  @override
  Future<Either<Failure, Success>> call(Params params) {
    return repository.deleteNote(params.name);
  }
}

class Params extends Equatable {
  final String name;

  const Params({required this.name});

  @override
  List<Object?> get props => throw UnimplementedError();
}