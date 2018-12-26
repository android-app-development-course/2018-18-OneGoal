import 'package:sqflite/sqflite.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';
import 'package:one_goal/ModelReadingNote.dart';

class Model {
  static Model _model = Model._internal();
  factory Model() {
    return _model;
  }
  Model._internal();

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    readingNoteProvider = new ReadingNoteProvider();
    var databasePath = await getDatabasesPath();
    readingNoteProvider.open(join(databasePath, 'onegoal.db'));
  }

  static const String _INITIALIZED = 'initialized';
  static const String _GOAL_NAME = 'goal_name';
  static const String _GOAL_TYPE = 'goal_type';
  static const String _BEGIN_TIME = 'begin_time';
  static const String _END_TIME = 'end_time';

  static const String NOT_INITIALIZED = 'not initialized';
  static const String READ = 'reading';
  static const String SLEEP = 'sleeping';
  static const String WEIGHT = 'weighting';

  static const String TYPE_MISMATCH = "type mismatch";

  static const String BOOK_NAME = 'book name';
  static const String BOOK_PAGES = 'book pages';


  SharedPreferences _sharedPreferences;
  ReadingNoteProvider readingNoteProvider;

  bool isInitializing() {
    return _sharedPreferences.getBool(_INITIALIZED) ?? false;
  }

  // -------------- global settings begin ------------

  void setInitialized() {
    _sharedPreferences.setBool(_INITIALIZED, true);
  }

  String getGoalType() {
    return _sharedPreferences.getString(_GOAL_TYPE) ?? NOT_INITIALIZED;
  }

  void setGoalType(String str) {
    _sharedPreferences.setString(_GOAL_TYPE, str);
  }
  String getGoalName() {
    return _sharedPreferences.getString(_GOAL_NAME) ?? NOT_INITIALIZED;
  }

  void setGoalName(String str) {
    _sharedPreferences.setString(_GOAL_NAME, str);
  }

  DateTime getBeginTime() {
    String timeStr = _sharedPreferences.getString(_BEGIN_TIME) ?? NOT_INITIALIZED;
    return DateTime.parse(timeStr);
  }
  DateTime getEndTime() {
    String timeStr = _sharedPreferences.getString(_END_TIME) ?? NOT_INITIALIZED;
    return DateTime.parse(timeStr);
  }

  void setBeginAndEndTime(DateTime beginDateTime, DateTime endDateTime) {
    String begin = beginDateTime.toIso8601String();
    String end = endDateTime.toIso8601String();
    _sharedPreferences.setString(_BEGIN_TIME, begin);
    _sharedPreferences.setString(_END_TIME, end);
  }

  // -------------- global settings end ------------

  // -------------- Reading plan data access begin ------------


  String getBookName() {
    if (getGoalType() != READ) return TYPE_MISMATCH;
    return _sharedPreferences.getString(BOOK_NAME) ?? NOT_INITIALIZED;
  }

  void setBookName(String bookName) {
    _sharedPreferences.setString(BOOK_NAME, bookName);
  }

  String getBookPages() {
    if (getGoalType() != READ) return TYPE_MISMATCH;
    return _sharedPreferences.getString(BOOK_PAGES) ?? NOT_INITIALIZED;
  }

  void setBookPages(String bookPages) {
    _sharedPreferences.setString(BOOK_PAGES, bookPages);
  }

  void insertReadingNote(ReadingNote note) {
    readingNoteProvider.insert(note);
  }

  Future<List<ReadingNote>> getAllReadingNotes() async {
    List<ReadingNote> result = await readingNoteProvider.getReadingNotes();
    return result;
  }



  // -------------- Reading plan data access end ------------


}
