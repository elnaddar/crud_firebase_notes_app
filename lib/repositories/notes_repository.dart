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

  Stream<QuerySnapshot> getNotesStream() {
    return _notes.orderBy('timestamp', descending: true).snapshots();
  }

  Future<void> updateNote(String docId, {String? newTitle, String? newNote}) {
    assert(newNote == null && newNote == null);
    final Map<Object, Object?> mp = {};
    if (newTitle != null) {
      mp['title'] = newTitle;
    }
    if (newNote != null) {
      mp['title'] = newNote;
    }
    return _notes.doc(docId).update(mp);
  }
}
