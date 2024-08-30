import 'package:notes/database/notesModel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class AppDataBase {
  // Private Constructor
  AppDataBase._privateConstructor();

  static final AppDataBase instance = AppDataBase._privateConstructor();
  Database? myDB;

  /// Table names
  static const String NOTES_TABLE = "notes";
  static const String USER_TABLE = "users";

  /// Notes columns
  static const String COLUMN_NOTE_ID = "noteID";
  static const String COLUMN_NOTE_TITLE = "title";
  static const String COLUMN_NOTE_DESC = "description"; // Changed from 'noteID' to 'description'

  /// User columns
  static const String COLUMN_USER_ID = "uId";
  static const String COLUMN_USER_NAME = "uName";
  static const String COLUMN_USER_EMAIL = "uEmail";
  static const String COLUMN_USER_NUMBER = "uNumber";
  static const String COLUMN_USER_PASSWORD = "uPassword";

  /// Open database
  Future<Database> initDB() async {
    var docDirectory = await getApplicationDocumentsDirectory();
    var dbPath = join(docDirectory.path, "noteDb.db");
    return await openDatabase(dbPath, version: 1,
        onCreate: (db, version) async {
          /// Create table for notes
          await db.execute('''
        CREATE TABLE $NOTES_TABLE (
          $COLUMN_NOTE_ID INTEGER PRIMARY KEY AUTOINCREMENT,
          $COLUMN_NOTE_TITLE TEXT,
          $COLUMN_NOTE_DESC TEXT
        )
      ''');

          /// Create table for users
          await db.execute('''
        CREATE TABLE $USER_TABLE (
          $COLUMN_USER_ID INTEGER PRIMARY KEY AUTOINCREMENT,
          $COLUMN_USER_NAME TEXT,
          $COLUMN_USER_EMAIL TEXT UNIQUE,
          $COLUMN_USER_NUMBER TEXT,
          $COLUMN_USER_PASSWORD TEXT
        )
      ''');
        });
  }

  // Get database instance, create if it doesn't exist
  Future<Database> getDB() async {
    if (myDB != null) {
      return myDB!;
    } else {
      myDB = await initDB();
      return myDB!;
    }
  }

  /// Add a new note
  Future<bool> addNote(NotesModel newNote) async {
    var db = await getDB();
    var rowEffected = await db.insert(NOTES_TABLE, newNote.toMap());
    return rowEffected > 0;
  }

  /// Update an existing note
  Future<bool> updateNote(NotesModel updatedNote) async {
    var db = await getDB();
    var rowEffected = await db.update(
      NOTES_TABLE,
      updatedNote.toMap(),
      where: '$COLUMN_NOTE_ID = ?',
      whereArgs: [updatedNote.id],
    );
    return rowEffected > 0;
  }

  /// Delete a note
  Future<bool> deleteNote(int noteID) async {
    var db = await getDB();
    var rowEffected = await db.delete(
      NOTES_TABLE,
      where: '$COLUMN_NOTE_ID = ?',
      whereArgs: [noteID],
    );
    return rowEffected > 0;
  }

  /// Fetch all notes
  Future<List<NotesModel>> fetchAllNotes() async {
    var db = await getDB();
    var result = await db.query(NOTES_TABLE);
    return result.isNotEmpty
        ? result.map((note) => NotesModel.fromMap(note)).toList()
        : [];
  }
}
