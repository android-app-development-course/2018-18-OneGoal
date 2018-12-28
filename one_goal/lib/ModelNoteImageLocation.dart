import 'package:sqflite/sqflite.dart';

final String tableNoteLoc = 'notes_image_location';
final String columnId = '_id';
final String columnNoteId = 'note_id';
final String columnPath = 'path';

class NoteImageLocation {
  int id;
  int noteId;
  String path;

  NoteImageLocation({this.noteId, this.path});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      columnNoteId: noteId,
      columnPath: path
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  static NoteImageLocation fromMap(Map<String, dynamic> singleMap) {
    var note = new NoteImageLocation(
        noteId: singleMap[columnNoteId],
        path: singleMap[columnPath]
    );
    note.id = singleMap[columnId];
    return note;
  }

  static List<NoteImageLocation> fromMaps(List<Map<String, dynamic>> maps) {
    var newList = new List<NoteImageLocation>();
    for (var i = 0; i != maps.length; ++i) {
      var note = new NoteImageLocation();
      var singleMap = maps[i];
      note.id = singleMap[columnId];
      note.noteId = singleMap[columnNoteId];
      note.path = singleMap[columnPath];
      newList.add(note);
    }
    return newList;
  }
}

class NoteImageLocationProvider {
  Database db;

  NoteImageLocationProvider(this.db);

  Future<NoteImageLocation> insert(NoteImageLocation note) async {
    note.id = await db.insert(tableNoteLoc, note.toMap());
    return note;
  }

  Future<List<NoteImageLocation>> getNoteImageLocations() async {
    List<Map> maps = await db.query(tableNoteLoc,
      columns: [columnId, columnNoteId, columnNoteId],
      where: null,
    );
    if (maps.length > 0) {
      return NoteImageLocation.fromMaps(maps);
    }
    return List<NoteImageLocation>();
  }

  Future<NoteImageLocation> getNoteImageLocation(int id) async {
    List<Map> maps = await db.query(tableNoteLoc,
        columns: [columnId, columnNoteId, columnNoteId],
        where: "$columnId = ?",
        whereArgs: [id]
    );
    if (maps.length > 0) return NoteImageLocation.fromMap(maps.first);
    return null;
  }

  Future<int> update(NoteImageLocation note) async {
    return await db.update(tableNoteLoc, note.toMap(),
        where: '$columnId = ?', whereArgs: [note.id]
    );
  }

}
