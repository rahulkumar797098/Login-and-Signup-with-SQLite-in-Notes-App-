import 'package:flutter/material.dart';
import 'package:notes/Colors.dart';
import 'package:notes/database/notesModel.dart';
import '../database/app_data_base.dart';

class NotesCreate extends StatefulWidget {
  const NotesCreate({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _NotesCreateState();
}

class _NotesCreateState extends State<NotesCreate> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Write Notes",
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: "Note Title",
                border: const OutlineInputBorder(),
                suffixIcon: const Icon(Icons.title , color:AppColors.appEditBox2, size: 25,),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                        width: 2, color: AppColors.appEditBox3)),
                disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                        width: 2, color: AppColors.appEditBox3)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                        width: 2, color: AppColors.appEditBox3)),
              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: descriptionController,
              maxLines: 10,
              decoration: InputDecoration(
                hintText: "Note Description",
                border: const OutlineInputBorder(),
                suffixIcon: const Icon(Icons.description , size: 25, color: AppColors.appEditBox4,),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                        width: 2, color: AppColors.appEditBox3)),
                disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                        width: 2, color: AppColors.appEditBox3)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                        width: 2, color: AppColors.appEditBox3)),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 2, color: AppColors.appEditBox4),
                          borderRadius: BorderRadius.circular(5))),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                        fontFamily: "myFontFirst",
                        color: Colors.red,
                        fontSize: 25,
                        shadows: [Shadow(color: Colors.black, blurRadius: 2)]),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    var newNote = NotesModel(
                      title: titleController.text,
                      description: descriptionController.text,
                      note_id: 0,
                      user_id: 0,
                    );

                    setState(() {
                      AppDataBase.instance.addNote(newNote);
                    });
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.appLight,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                  child: const Text(
                    "Save",
                    style: TextStyle(
                        fontFamily: "myFontFirst",
                        fontSize: 25,
                        shadows: [Shadow(color: Colors.black, blurRadius: 2)]),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
