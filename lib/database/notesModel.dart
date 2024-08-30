import 'package:flutter/cupertino.dart';

class NotesModel {
  final int? id;
  final String title;
  final String description; // Changed 'message' to 'description'

  NotesModel({this.id, required this.title, required this.description});

  NotesModel.fromMap(Map<String, dynamic> res)
      : id = res['noteID'], // Corrected the key name to match the column
        title = res['title'],
        description = res['description']; // Corrected the key name

  Map<String, dynamic> toMap() {
    return {
      "noteID": id, // Corrected the key name to match the column
      "title": title,
      "description": description, // Corrected the key name
    };
  }
}
