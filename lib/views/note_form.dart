import 'package:crud_firebase_notes_app/models/note_model.dart';
import 'package:crud_firebase_notes_app/repositories/notes_repository.dart';
import 'package:crud_firebase_notes_app/shared/form_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum NoteFormNames { title, note }

class NoteForm extends StatefulWidget {
  const NoteForm({
    super.key,
  });

  @override
  State<NoteForm> createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteForm> {
  final _formMap = FormMap<NoteFormNames>();
  _handleFormSubmit(Map<String, dynamic> data) {
    context.read<NotesRepository>().addNote(
          NoteModel.fromFormMap(data),
        );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formMap.key,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(hintText: "Title"),
              initialValue: _formMap[NoteFormNames.title],
              onSaved: (newValue) => _formMap[NoteFormNames.title] = newValue,
            ),
            const SizedBox(height: 12),
            TextFormField(
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                  hintText: "Description", errorMaxLines: 4),
              maxLines: 5,
              minLines: 5,
              initialValue: _formMap[NoteFormNames.note],
              onSaved: (newValue) => _formMap[NoteFormNames.note] = newValue,
              validator: (value) {
                if (value == null || value.trim().length < 3) {
                  return "Description is required and can't be less than 3 characters.";
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    style: TextButton.styleFrom(foregroundColor: Colors.red),
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("Cancle")),
                TextButton(
                    onPressed: () => _formMap.submit(_handleFormSubmit),
                    child: const Text("Create")),
              ],
            )
          ],
        ));
  }
}
