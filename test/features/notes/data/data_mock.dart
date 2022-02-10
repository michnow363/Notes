import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:notes/core/GetTimeInterface.dart';
import 'package:notes/features/notes/data/datasources/note_datasource.dart';

@GenerateMocks([NoteDatasource, HiveInterface, Box, GetTimeInterfaceImpl])
class DataMock {}