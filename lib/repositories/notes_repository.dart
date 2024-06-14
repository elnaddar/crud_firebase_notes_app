import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase_notes_app/models/note_model.dart';
import 'package:crud_firebase_notes_app/services/firestore_service.dart';

class NotesRepository {
  final FirestoreService firestoreService;
  final CollectionReference _notes;
  NotesRepository({required this.firestoreService})
      : _notes = firestoreService['notes'];

  Future<void> addNote(NoteModel note) {
    return _notes.add(note.toMap());
  }
}
