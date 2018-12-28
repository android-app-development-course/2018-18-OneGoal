import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseInitializer {
  static final String tableNote = 'notes';
  static final String columnId = '_id';
  static final String columnTitle = 'title';
  static final String columnContent = 'content';

  static final String tableSleepingNote = 'sleepingNotes';
  static final String columnDate = 'date';
  static final String columnTime = 'time';

  static final String tableNoteLoc = 'notes_image_location';
  static final String columnNoteId = 'note_id';
  static final String columnPath = 'path';

  static Database db;
  static Future initialize() async {
    var databasePath = await getDatabasesPath();
    await open(join(databasePath, 'onegoal.db'));
  }


  static Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('''
          create table $tableNote (
            $columnId integer primary key autoincrement,
            $columnTitle text not null,
            $columnContent text,
            $columnDate text)
        ''');
          await db.execute('''
          create table $tableSleepingNote (
            $columnId integer primary key autoincrement,
            $columnTitle text not null,
            $columnContent text,
            $columnDate text,
            $columnTime text)
        ''');
          await db.execute('''
          create table $tableNoteLoc (
            $columnId integer primary key autoincrement,
            $columnNoteId integer not null,
            $columnPath text)
        ''');
        }
    );
  }
}