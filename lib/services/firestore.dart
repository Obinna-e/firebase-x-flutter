import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/scheduler.dart';

class FirestoreService {
  // get collection of notes

  final CollectionReference notes =
      FirebaseFirestore.instance.collection('notes');

  // Create: add a new note
  Future<void> addNotes(String note) {
    return notes.add({
      'note': note,
      'timestamp': Timestamp.now(),
    });
  }
  //Read: get notes from database

  Stream<QuerySnapshot> getNotesStream() {
    final notesStream =
        notes.orderBy('timestamp', descending: true).snapshots();

    return notesStream;
  }
  //  Update: update notes given a doc id

  Future<void> updateNote(String docId, String newNote) {
    return notes.doc(docId).update({
      'note': newNote,
      'timestamp': Timestamp.now(),
    });
  }

  // Delete: delete notes given a doc id
  Future<void> deleteNote(String docId) {
    return notes.doc(docId).delete();
  }
}
