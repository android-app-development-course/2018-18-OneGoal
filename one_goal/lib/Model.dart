import 'package:sqflite/sqflite.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:one_goal/ModelReadingNote.dart';
import 'package:flutter/material.dart';
import 'ModelSleepingNote.dart';
import 'package:one_goal/DatabaseInitializer.dart';
import 'Utilities.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'ModelNoteImageLocation.dart';
import 'package:uuid/uuid.dart';


class Model {
  static Model _model = Model._internal();
  factory Model() {
    return _model;
  }
  Model._internal();

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    await DatabaseInitializer.initialize();
    readingNoteProvider = new ReadingNoteProvider(DatabaseInitializer.db);
    sleepingNoteProvider = new SleepingNoteProvider(DatabaseInitializer.db);
    noteImageLocationProvider = new NoteImageLocationProvider(DatabaseInitializer.db);
    directory = await getApplicationDocumentsDirectory();
  }

  static const String _INITIALIZED = 'initialized';
  static const String _GOAL_NAME = 'goal_name';
  static const String _GOAL_TYPE = 'goal_type';
  static const String _BEGIN_DATE_TIME = 'begin_date_time';
  static const String _BEGIN_TIME_OF_DAY = 'begin_time_of_day';
  static const String _END_DATE_TIME = 'begin_date_time';
  static const String _END_TIME_OF_DAY = 'begin_time_of_day';

  static const String NOT_INITIALIZED = 'not_initialized';
  static const String READ = 'reading';
  static const String SLEEP = 'sleeping';
  static const String WEIGHT = 'weighting';

  static const String TYPE_MISMATCH = "type_mismatch";

  static const String BOOK_NAME = 'book_name';
  static const String BOOK_PAGES = 'book_pages';
  static const String CURRENT_BOOK_PAGES = 'current_book_pages';

  static const String FREQUENCY = 'frequency';

  SharedPreferences _sharedPreferences;
  ReadingNoteProvider readingNoteProvider;
  SleepingNoteProvider sleepingNoteProvider;
  NoteImageLocationProvider noteImageLocationProvider;
  Uuid uuid = new Uuid();

  Directory directory;

  // -------------- global settings begin ------------

  bool hasInitialized() {
    return _sharedPreferences.getBool(_INITIALIZED) ?? false;
  }

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


  // --- time related begin ----

  DateTime getBeginDateTime() {  
    String timeStr = _sharedPreferences.getString(_BEGIN_DATE_TIME) ??
        DateTime.now().toIso8601String();
    return DateTime.parse(timeStr);
  }
  void setBeginDateTime(DateTime dateTime) {
    _sharedPreferences.setString(_BEGIN_DATE_TIME, dateTime.toIso8601String());
  }

  DateTime getEndDateTime() {
    String timeStr = _sharedPreferences.getString(_END_DATE_TIME) ??
        DateTime.now().toIso8601String();
    return DateTime.parse(timeStr);
  }
  void setEndDateTime(DateTime dateTime) {
    _sharedPreferences.setString(_END_DATE_TIME, dateTime.toIso8601String());
  }


  TimeOfDay getBeginTimeOfDay() {
    String timeStr = _sharedPreferences.getString(_BEGIN_TIME_OF_DAY) ??
        Utilities.time2String(TimeOfDay.now());
    return Utilities.string2Time(timeStr);
  }
  void setBeginTimeOfDay(TimeOfDay time) {
    _sharedPreferences.setString(_BEGIN_TIME_OF_DAY, Utilities.time2String(time));
  }

  TimeOfDay getEndTimeOfDay() {
    String timeStr = _sharedPreferences.getString(_END_TIME_OF_DAY) ??
        Utilities.time2String(TimeOfDay.now());
    return Utilities.string2Time(timeStr);
  }
  void setEndTimeOfDay(TimeOfDay time) {
    _sharedPreferences.setString(_END_TIME_OF_DAY, Utilities.time2String(time));
  }

  // --- time related end ----

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
    return _sharedPreferences.getString(BOOK_PAGES) ?? "0";
  }

  void setBookPages(String bookPages) {
    _sharedPreferences.setString(BOOK_PAGES, bookPages);
  }
  String getCurrentBookPages() {
    if (getGoalType() != READ) return TYPE_MISMATCH;
    return _sharedPreferences.getString(CURRENT_BOOK_PAGES) ?? "0";
  }

  void setCurrentBookPages(String bookPages) {
    _sharedPreferences.setString(CURRENT_BOOK_PAGES, bookPages);
  }

  Future<int> insertReadingNote(ReadingNote note) async {
    var res = await readingNoteProvider.insert(note);
    return res.id;
  }

  Future<List<ReadingNote>> getAllReadingNotes() async {
    List<ReadingNote> result = await readingNoteProvider.getReadingNotes();
    return result;
  }

  Future<ReadingNote> getReadingNote(int id) async {
    if (id == null) return new ReadingNote();
    var result = await readingNoteProvider.getReadingNote(id);
    return result;
  }

  Future<int> updateReadingNote(ReadingNote note) async {
    return await readingNoteProvider.update(note);
  }

  Future saveImages(int noteId, List<File> images) async {
    for (var i = 0; i != images.length; ++i) {
      String path = '${directory.path}/${uuid.v1()}.jpg';
      images[i].copy(path);
      var imgLoc = new NoteImageLocation(noteId: noteId, path: path);
      noteImageLocationProvider.insert(imgLoc);
    }
  }

  Future<List<File>> loadImages(int noteId) async {
    print(noteId);
    if (noteId == null) return new List<File>();
    List<NoteImageLocation> locs =
      await noteImageLocationProvider.getNoteImageLocation(noteId);
    print("locs.length: " + locs.length.toString());
    var fileList = new List<File>();
    locs.forEach((loc) {
      File imgFile = File(loc.path);
      fileList.add(imgFile);
    });
    return fileList;
  }

  Future<List<File>> loadAllImages() async {
    List<NoteImageLocation> locs = await noteImageLocationProvider.getNoteImageLocations();
    var fileList = new List<File>();
    locs.forEach((loc) {
      File imgFile = File(loc.path);
      fileList.add(imgFile);
    });
    return fileList;
  }

  // -------------- Reading plan data access end ------------


  // -------------- Sleeping plan data access begin ------------


  void insertSleepingNote(SleepingNote note) {
    sleepingNoteProvider.insert(note.toSleepingNote4DB());  // fixme: need synchronize
  }

  Future<List<SleepingNote>> getAllSleepingNotes() async {
    List<SleepingNote4DB> resultdb = await sleepingNoteProvider.getSleepingNotes();
    var result = new List<SleepingNote>();
    for (var i = 0; i != resultdb.length; ++i) {
      result.add(SleepingNote.fromSleepingNote4DB(resultdb[i]));
    }
    return result;
  }

  Future<SleepingNote> getSleepingNote(int id) async {
    var result = await sleepingNoteProvider.getSleepingNote(id);
    return SleepingNote.fromSleepingNote4DB(result);
  }

  Future<int> updateSleepingNote(SleepingNote note) async {
    return await sleepingNoteProvider.update(note.toSleepingNote4DB());
  }


  // -------------- Sleeping plan data access end ------------

  // -------------- Setting data access start ---------------

  void setFrequency(String value) {
    _sharedPreferences.setString(FREQUENCY, value);
  }

  String getFrequency() {
    return _sharedPreferences.getString(FREQUENCY);
  }

  // ----------------- Setting data access end ------------


  // ----------------- Clear data start ---------------------------

  void clearData()
  {
    _sharedPreferences.clear();
  }

  // ----------------- Clear data end ---------------------------

}