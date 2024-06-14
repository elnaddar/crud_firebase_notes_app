import 'package:crud_firebase_notes_app/firebase_options.dart';
import 'package:crud_firebase_notes_app/repositories/notes_repository.dart';
import 'package:crud_firebase_notes_app/services/firestore_service.dart';
import 'package:crud_firebase_notes_app/utils/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirestoreService firestoreService = FirestoreService();
  runApp(
    RepositoryProvider(
      create: (context) => NotesRepository(firestoreService: firestoreService),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "CRUD Firebase Notes",
      debugShowCheckedModeBanner: false,
      routes: routes,
      onGenerateRoute: onGenerateRoute,
    );
  }
}
