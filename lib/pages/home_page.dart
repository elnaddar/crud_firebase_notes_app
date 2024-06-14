import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase_notes_app/models/note_model.dart';
import 'package:crud_firebase_notes_app/repositories/notes_repository.dart';
import 'package:crud_firebase_notes_app/views/note_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _openNoteForm({String? id, NoteModel? note}) {
    showAdaptiveDialog(
      context: context,
      builder: (context) => AlertDialog.adaptive(
        title: const Text("Add new note"),
        content: NoteForm(
          id: id,
          note: note,
        ),
      ),
    );
  }

  void _deleteNote(String id) {
    showAdaptiveDialog(
      context: context,
      builder: (context) => AlertDialog.adaptive(
        title: const Text("Deleting a note"),
        content: const Text("Are you sure you want to delete this note?"),
        actions: [
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            onPressed: () {
              context.read<NotesRepository>().deleteNote(id);
              Navigator.of(context).pop();
            },
            child: const Text("OK"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancle"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openNoteForm,
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            RepositoryProvider.of<NotesRepository>(context).getNotesStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List notesList = snapshot.data!.docs;
            if (notesList.isEmpty) {
              return const Center(child: Text("No data"));
            }
            return ListView.builder(
              itemCount: notesList.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot doc = notesList[index];
                final id = doc.id;
                final data = doc.data() as Map<String, dynamic>;
                final note = NoteModel.fromMap(data);
                return ListTile(
                  title: Text(note.title ?? note.note),
                  subtitle: note.title != null ? Text(note.note) : null,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _openNoteForm(id: id, note: note),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteNote(id),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error try again"));
          } else {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
        },
      ),
    );
  }
}
