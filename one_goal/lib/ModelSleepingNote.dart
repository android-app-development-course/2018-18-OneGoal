import 'package:sqflite/sqflite.dart';

final String tableSleepingNote = 'sleepingNotes';
final String columnId = '_id';
final String columnTitle = 'title';
final String columnContent = 'content';
final String columnDate = 'date';
final String columnTime = 'time';


class SleepingNote {
  int id;
  String title;
  String content;
  String date;
  String time;

  SleepingNote({this.title, this.content, this.date, this.time});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      columnTitle: title,
      columnContent: content,
      columnDate: date,
      columnTime: time,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  static SleepingNote fromMap(Map<String, dynamic> singleMap) {
    var note = new SleepingNote(
        title: singleMap[columnTitle],
        content: singleMap[columnContent],
        date: singleMap[columnDate],
        time: singleMap[columnTime],
    );
    note.id = singleMap[columnId];
    return note;
  }

  static List<SleepingNote> fromMaps(List<Map<String, dynamic>> maps) {
    var newList = new List<SleepingNote>();
    for (var i = 0; i != maps.length; ++i) {
      var note = new SleepingNote();
      var singleMap = maps[i];
      note.id = singleMap[columnId];
      note.title = singleMap[columnTitle];
      note.content = singleMap[columnContent];
      note.date = singleMap[columnDate];
      note.time = singleMap[columnTime];
      newList.add(note);
    }
    return newList;
  }

}

class SleepingNoteProvider {
  Database db;
  SleepingNoteProvider(this.db);

  Future<SleepingNote> insert(SleepingNote note) async {
    note.id = await db.insert(tableSleepingNote, note.toMap());
    return note;
  }

  Future<List<SleepingNote>> getSleepingNotes() async {
    List<Map> maps = await db.query(tableSleepingNote,
      columns: [columnId, columnTitle, columnContent, columnDate, columnTime],
      where: null,
    );
    if (maps.length > 0) {
      return SleepingNote.fromMaps(maps);
    }
    return List<SleepingNote>();
  }

  Future<SleepingNote> getSleepingNote(int id) async {
    List<Map> maps = await db.query(tableSleepingNote,
        columns: [columnId, columnTitle, columnContent, columnDate, columnTime],
        where: "$columnId = ?",
        whereArgs: [id]
    );
    if (maps.length > 0) return SleepingNote.fromMap(maps.first);
    return null;
  }

  Future<int> update(SleepingNote note) async {
    return await db.update(tableSleepingNote, note.toMap(),
        where: '$columnId = ?', whereArgs: [note.id]
    );
  }

}