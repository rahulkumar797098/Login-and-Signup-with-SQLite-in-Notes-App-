import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/database/notesModel.dart';

import '../database/app_data_Base.dart';

class NotesCreate extends StatefulWidget {
  const NotesCreate({super.key});

  @override
  State<StatefulWidget> createState() => _NotesCreate();
}

class _NotesCreate extends State<NotesCreate> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Write Notes",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.save, size: 30),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  labelText: "Note Title",
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.title),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: descriptionController,
                keyboardType: TextInputType.multiline,
                maxLines: 10,
                decoration: const InputDecoration(
                  labelText: "Note Description",
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.description),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () async {
                  var newNote = NotesModel(
                    title: titleController.text,
                    description: descriptionController.text,
                  );
                  bool success =
                  await AppDataBase.instance.addNote(newNote);
                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Note Added Successfully"),
                      ),
                    );
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Failed to Add Note"),
                      ),
                    );
                  }
                },
                child: const Text("Save Note"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
