import 'package:crud_firebase_notes_app/models/note_model.dart';
import 'package:crud_firebase_notes_app/repositories/notes_repository.dart';
import 'package:crud_firebase_notes_app/shared/form_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum NoteFormNames { id, title, note }

class NoteForm extends StatefulWidget {
  const NoteForm({
    super.key,
    this.id,
    this.note,
  }) : assert((id == null && note == null) || (id != null && note != null));

  final String? id;
  final NoteModel? note;

  @override
  State<NoteForm> createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteForm> {
  late final FormMap<NoteFormNames> _formMap;

  @override
  void initState() {
    if (widget.note == null) {
      _formMap = FormMap<NoteFormNames>();
    } else {
      final map = widget.note!.toMap();
      map['id'] = widget.id;
      _formMap = FormMap<NoteFormNames>.fromDataMap(
        enumValues: NoteFormNames.values,
        dataMap: map,
      );
    }
    super.initState();
  }

  _handleFormSubmit(Map<String, dynamic> data) {
    final noteData = NoteModel.fromFormMap(data);
    if (widget.id != null) {
      context.read<NotesRepository>().updateNote(
            widget.id!,
            newNote: noteData.note,
            newTitle: noteData.title,
          );
    } else {
      context.read<NotesRepository>().addNote(NoteModel.fromFormMap(data));
    }

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
                    child: widget.id != null
                        ? const Text("Update")
                        : const Text("Create")),
              ],
            )
          ],
        ));
  }
}
