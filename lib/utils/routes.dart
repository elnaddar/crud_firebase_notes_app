import 'package:crud_firebase_notes_app/views/note_form.dart';
import 'package:flutter/material.dart';
import '/pages/pages.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  "/": (BuildContext context) => const HomePage(),
  "/note/create": (p0) => const NoteForm()
};

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  if (settings.name == '/note/edit') {
    final args = (settings.arguments as Map<String, dynamic>);
    return MaterialPageRoute(
      builder: (context) {
        return NoteForm(
          note: args['note'],
        );
      },
    );
  }
  // Handle other routes if necessary
  return null;
}
