import 'package:sqflite/sqflite.dart';

final String tableNote = 'notes';
final String columnId = '_id';
final String columnTitle = 'title';
final String columnContent = 'content';

class ReadingNote {
  int id;
  String title;
  String content;

  ReadingNote({this.title, this.content});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      columnTitle: title,
      columnContent: content
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  static ReadingNote fromMap(Map<String, dynamic> singleMap) {
    var note = new ReadingNote(
      title: singleMap[columnTitle],
      content: singleMap[columnContent]
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
      newList.add(note);
    }
    return newList;

//    return maps.map( (m) {    // why does't it work??
//      ReadingNote note = new ReadingNote();
//      note.id = m[columnId];
//      note.title = m[columnTitle];
//      note.content = m[columnContent];
//      return note;
//    }
//    );
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
      columns: [columnId, columnTitle, columnContent],
      where: null,
    );
    if (maps.length > 0) {
      return ReadingNote.fromMaps(maps);
    }
    return List<ReadingNote>();
  }

  Future<ReadingNote> getReadingNote(int id) async {
    List<Map> maps = await db.query(tableNote,
      columns: [columnId, columnTitle, columnContent],
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
