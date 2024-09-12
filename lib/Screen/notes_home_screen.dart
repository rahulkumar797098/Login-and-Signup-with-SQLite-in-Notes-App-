import 'package:flutter/material.dart';
import 'package:notes/database/notesModel.dart';
import '../database/app_data_Base.dart';
import 'create_notes_screen.dart';
import 'edit_notes_screen.dart';

class NotesHomeScreen extends StatefulWidget {
  const NotesHomeScreen({super.key});

  @override
  State<NotesHomeScreen> createState() => _NotesHomeScreenState();
}

class _NotesHomeScreenState extends State<NotesHomeScreen> {
  late Future<List<NotesModel>> _notesList;

  @override
  void initState() {
    super.initState();
    _fetchNotes();
  }

  void _fetchNotes() {
    _notesList = AppDataBase.instance.fetchAllNotes();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NotesCreate()),
          );
          setState(() {
            _fetchNotes(); // Refresh the notes list after adding a new note
          });
        },
        backgroundColor: Colors.blueAccent.shade200,
        foregroundColor: Colors.white,
        label: const Row(
          children: [
            Icon(
              Icons.add,
              size: 30,
              shadows: [
                BoxShadow(
                    blurRadius: 5,
                    color: Colors.black,
                    offset: Offset(1.0, 1.0))
              ],
            ),
            Text(
              "Notes",
              style: TextStyle(fontSize: 25, shadows: [
                BoxShadow(
                    color: Colors.black,
                    blurRadius: 5,
                    offset: Offset(1.0, 1.0))
              ]),
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text("Notes"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<NotesModel>>(
        future: _notesList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching notes'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return  Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icon/folder.png",
                    height: 50,
                  ),
                  const Text("No notes available"),
                ],
              ),
            );
          } else {
            var notes = snapshot.data!;
            return ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                var note = notes[index];
                return Card(
                  child: ListTile(
                    title: Text(note.title),
                    subtitle: Text(note.description),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Delete
                        IconButton(
                          onPressed: () async {
                            await AppDataBase.instance.deleteNote(note.note_id!);
                            setState(() {
                              _fetchNotes();
                            });
                          },
                          icon: const Icon(
                            Icons.delete,
                            size: 25,
                            color: Colors.red,
                          ),
                        ),

                        // Edit
                        IconButton(
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EditNotesScreen(notes: note),
                              ),
                            );
                            setState(() {
                              _fetchNotes(); // Refresh notes list after editing
                            });
                          },
                          icon: const Icon(
                            Icons.edit,
                            size: 25,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}