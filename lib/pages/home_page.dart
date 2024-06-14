import 'package:crud_firebase_notes_app/views/note_form.dart';
import 'package:flutter/material.dart';

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
    );
  }
}
