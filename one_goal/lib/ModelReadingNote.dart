import 'package:sqflite/sqflite.dart';

final String tableNote = 'notes';
final String columnId = '_id';
final String columnTitle = 'title';
final String columnContent = 'content';
final String columnDate = 'date';

class ReadingNote {
  int id;
  String title;
  String content;
  String time;

  ReadingNote({this.title, this.content, this.time}) {
    if (time == null || time.isEmpty)
      this.time = DateTime.now().toIso8601String();
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      columnTitle: title,
      columnContent: content,
      columnDate: time,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  static ReadingNote fromMap(Map<String, dynamic> singleMap) {
    var note = new ReadingNote(
      title: singleMap[columnTitle],
      content: singleMap[columnContent],
      time: singleMap[columnDate],
    );
    note.id = singleMap[columnId];
    return note;
  }

  static List<ReadingNote> fromMaps(List<Map<String, dynamic>> maps) {
    var newList = new List<ReadingNote>();
    for (var i = 0; i != maps.length; ++i) {
      var note = new ReadingNote();
      var singleMap = maps[i];
      note.id = singleMap[columnId];
      note.title = singleMap[columnTitle];
      note.content = singleMap[columnContent];
      note.time = singleMap[columnDate];
      newList.add(note);
    }
    return newList;
  }
}

class ReadingNoteProvider {
  Database db;

  ReadingNoteProvider(this.db);

  Future<ReadingNote> insert(ReadingNote note) async {
    note.id = await db.insert(tableNote, note.toMap());
    return note;
  }

  Future<List<ReadingNote>> getReadingNotes() async {
    List<Map> maps = await db.query(tableNote,
      columns: [columnId, columnTitle, columnContent, columnDate],
      where: null,
    );
    if (maps.length > 0) {
      return ReadingNote.fromMaps(maps);
    }
    return List<ReadingNote>();
  }

  Future<ReadingNote> getReadingNote(int id) async {
    List<Map> maps = await db.query(tableNote,
      columns: [columnId, columnTitle, columnContent, columnDate],
      where: "$columnId = ?",
      whereArgs: [id]
    );
    if (maps.length > 0) return ReadingNote.fromMap(maps.first);
    return null;
  }

  Future<int> update(ReadingNote note) async {
    return await db.update(tableNote, note.toMap(),
      where: '$columnId = ?', whereArgs: [note.id]
    );
  }

}
