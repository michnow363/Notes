import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/note_repository.dart';

class DeleteNote implements UseCase<void, Params>{
  final NoteRepository repository;

  DeleteNote({required this.repository});

  @override
  Future<Either<Failure, void>> call(Params params) {
    return repository.deleteNote(params.name);
  }
}

class Params extends Equatable {
  final String name;

  const Params({required this.name});

  @override
  List<Object?> get props => throw UnimplementedError();
}