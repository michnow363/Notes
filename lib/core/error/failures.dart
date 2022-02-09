import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetNoteFailure extends Failure {}
class CreateNoteFailure extends Failure {}
class UpdateNoteFailure extends Failure {}
class DeleteNoteFailure extends Failure {}