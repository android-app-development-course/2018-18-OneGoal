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

  static List<ReadingNote> fromMaps(List<Map<String, dynamic>> maps) {
    return maps.map( (m) {
      ReadingNote note = new ReadingNote();
      note.id = m[columnId];
      note.title = m[columnTitle];
      note.content = m[columnContent];
      return note;
    }
    );
  }
}

class ReadingNoteProvider {
  Database db;
  Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('''
          create table $tableNote (
            $columnId integer primary key autoincrement,
            $columnTitle text not null,
            $columnContent text)
        ''');
        }
    );
  }

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

}
