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
    maps.forEach((singleMap) {
      var note = new NoteImageLocation();
      note.id = singleMap[columnId];
      note.noteId = singleMap[columnNoteId];
      note.path = singleMap[columnPath];
      newList.add(note);
    });
    return newList;
  }
}

class NoteImageLocationProvider {
  Database db;

  NoteImageLocationProvider(this.db);

  Future<NoteImageLocation> insert(NoteImageLocation note) async {
    print("insert: " + note.path);
    note.id = await db.insert(tableNoteLoc, note.toMap());
    return note;
  }

  Future delete(int noteId, String imagePath) async {
    print("delete: " + imagePath);
    await db.delete(tableNoteLoc,
        where: "$columnNoteId = ? and $columnPath = ?",
        whereArgs: [noteId, imagePath]
    );
  }

  Future deleteAllOf(int noteId) async {
    print("delete all of $noteId");
    await db.delete(tableNoteLoc,
      where: "$columnNoteId = ?",
      whereArgs: [noteId]
    );
  }

  Future<List<NoteImageLocation>> getNoteImageLocations() async {
    List<Map> maps = await db.query(tableNoteLoc,
      columns: [columnId, columnNoteId, columnPath],
      where: null,
    );
    return NoteImageLocation.fromMaps(maps);
  }

  Future<List<NoteImageLocation>> getNoteImageLocation(int id) async {
    List<Map> maps = await db.query(tableNoteLoc,
        columns: [columnId, columnNoteId, columnPath],
        where: "$columnNoteId = ?",
        whereArgs: [id]
    );
    print(maps);
    return NoteImageLocation.fromMaps(maps);
  }

  Future<int> update(NoteImageLocation note) async {
    return await db.update(tableNoteLoc, note.toMap(),
        where: '$columnId = ?', whereArgs: [note.id]
    );
  }

}
