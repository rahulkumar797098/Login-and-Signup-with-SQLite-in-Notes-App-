import 'app_data_base.dart';

class NotesModel {
  int note_id;
  int user_id ;
  String title;
  String description;

  NotesModel({
    required this.note_id,
    required this.title,
    required this.user_id ,
    required this.description,

  });

  factory NotesModel.fromMap(Map<String, dynamic> map) {
    return NotesModel(
      user_id: map[AppDataBase.COLUMN_USER_ID],
      note_id: map[AppDataBase.COLUMN_NOTE_ID],
      title: map[AppDataBase.COLUMN_NOTE_TITLE],
      description: map[AppDataBase.COLUMN_NOTE_DESC],

    );
  }

  Map<String, dynamic> toMap() {
    return {
      AppDataBase.COLUMN_USER_ID : user_id ,
      AppDataBase.COLUMN_NOTE_TITLE: title,
      AppDataBase.COLUMN_NOTE_DESC: description,
    };
  }
}
