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
  void _createNewNote() {
    showAdaptiveDialog(
      context: context,
      builder: (context) => const AlertDialog.adaptive(
        title: Text("Add new note"),
        content: NoteForm(),
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
        onPressed: _createNewNote,
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
                final data = doc.data() as Map<String, dynamic>;
                final note = NoteModel.fromMap(data);
                return ListTile(
                  title: Text(note.title ?? note.note),
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
