import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/error/successes.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/note_repository.dart';

class UpdateNote implements UseCase<Success, Params>{
  final NoteRepository repository;

  UpdateNote({required this.repository});

  @override
  Future<Either<Failure, Success>> call(Params params) {
    return repository.updateNote(params.name, params.newContent);
  }
}

class Params extends Equatable {
  final String name;
  final String newContent;

  const Params({required this.name, required this.newContent});

  @override
  List<Object?> get props => throw UnimplementedError();
}