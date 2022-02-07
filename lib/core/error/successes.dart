import 'package:equatable/equatable.dart';

abstract class Success extends Equatable {
  @override
  List<Object?> get props => [];
}

class DeleteSuccess extends Success { }
class UpdateSuccess extends Success { }