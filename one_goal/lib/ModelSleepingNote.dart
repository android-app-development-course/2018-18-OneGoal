import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'Utilities.dart';

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
  DateTime date;
  TimeOfDay time;

  SleepingNote({this.title, this.content, this.date, this.time});

  SleepingNote4DB toSleepingNote4DB() {
    var dbnote = new SleepingNote4DB(
      title: title,
      content: content,
      date: date.toIso8601String(),
      time: Utilities.time2String(time),
    );
    dbnote.id = id;
    return dbnote;
  }

  static SleepingNote fromSleepingNote4DB(SleepingNote4DB n4db) {
    var note = new SleepingNote(
      title: n4db.title,
      content: n4db.content,
      date: DateTime.parse(n4db.date),
      time: Utilities.string2Time(n4db.time)
    );
    note.id = n4db.id;
    return note;
  }
}

// This struct is used for database, use SleepingNote instead
class SleepingNote4DB {
  int id;
  String title;
  String content;
  String date;
  String time;

  SleepingNote4DB({this.title, this.content, this.date, this.time});

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

  static SleepingNote4DB fromMap(Map<String, dynamic> singleMap) {
    var note = new SleepingNote4DB(
        title: singleMap[columnTitle],
        content: singleMap[columnContent],
        date: singleMap[columnDate],
        time: singleMap[columnTime],
    );
    note.id = singleMap[columnId];
    return note;
  }

  static List<SleepingNote4DB> fromMaps(List<Map<String, dynamic>> maps) {
    var newList = new List<SleepingNote4DB>();
    for (var i = 0; i != maps.length; ++i) {
      var note = new SleepingNote4DB();
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

  Future<SleepingNote4DB> insert(SleepingNote4DB note) async {
    note.id = await db.insert(tableSleepingNote, note.toMap());
    return note;
  }

  Future<List<SleepingNote4DB>> getSleepingNotes() async {
    List<Map> maps = await db.query(tableSleepingNote,
      columns: [columnId, columnTitle, columnContent, columnDate, columnTime],
      where: null,
    );
    if (maps.length > 0) {
      return SleepingNote4DB.fromMaps(maps);
    }
    return List<SleepingNote4DB>();
  }

  Future<SleepingNote4DB> getSleepingNote(int id) async {
    List<Map> maps = await db.query(tableSleepingNote,
        columns: [columnId, columnTitle, columnContent, columnDate, columnTime],
        where: "$columnId = ?",
        whereArgs: [id]
    );
    if (maps.length > 0) return SleepingNote4DB.fromMap(maps.first);
    return null;
  }

  Future<int> update(SleepingNote4DB note) async {
    return await db.update(tableSleepingNote, note.toMap(),
        where: '$columnId = ?', whereArgs: [note.id]
    );
  }

}