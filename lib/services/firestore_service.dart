import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  CollectionReference operator [](String collectionName) {
    return FirebaseFirestore.instance.collection(collectionName);
  }
}
