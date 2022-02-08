import 'package:hive/hive.dart';
import 'package:notes/features/notes/domain/entities/note.dart';

@HiveType(typeId: 1)
class NoteModel extends Note {
  NoteModel({required this.name, required this.content, required this.date,}) :
        super(name: name, content: content, creationDate: date);

  @HiveField(0)
  String name;

  @HiveField(1)
  String content;

  @HiveField(2)
  DateTime date;
}