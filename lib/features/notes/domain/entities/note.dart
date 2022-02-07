import 'package:equatable/equatable.dart';

class Note extends Equatable {
  final String content;
  final DateTime creationDate;

  const Note({
    required this.content,
    required this.creationDate,
  });

  @override
  List<Object?> get props => [content, creationDate];
}