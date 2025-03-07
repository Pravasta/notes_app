import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_app/core/repositories/notes_model.dart';

abstract class FirebaseFirestoreService {
  Future<String> addNotes(String notesId, String title, String text);
  Future<String> deleteNotes(String id);
  Future<String> updateNotes(String notesId, String title, String text);
  Future<List<NotesModel>> getNotes();
  Future<NotesModel> getNotesById(String notesId);
}

class FirebaseFirestoreServiceImpl implements FirebaseFirestoreService {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  FirebaseFirestoreServiceImpl({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
  }) : _firestore = firestore,
       _auth = auth;

  @override
  Future<String> addNotes(String notesId, String title, String text) async {
    try {
      final currentUser = _auth.currentUser;
      await _firestore
          .collection('users')
          .doc(currentUser!.uid)
          .collection('notes')
          .doc('${currentUser.uid}$notesId')
          .set({
            'title': title,
            'text': text,
            'createdAt': DateTime.now(),
            'id': '${currentUser.uid}$notesId',
            'updatedAt': DateTime.now(),
          });

      return 'Notes added successfully';
    } on FirebaseException catch (e) {
      return e.message.toString();
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Future<String> deleteNotes(String notesId) async {
    final currentUser = _auth.currentUser;
    try {
      await _firestore
          .collection('users')
          .doc(currentUser!.uid)
          .collection('notes')
          .doc(notesId)
          .delete();
      return 'Notes deleted successfully';
    } on FirebaseException catch (e) {
      return e.message.toString();
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Future<List<NotesModel>> getNotes() async {
    try {
      final currentUser = _auth.currentUser;

      final notes =
          await _firestore
              .collection('users')
              .doc(currentUser!.uid)
              .collection('notes')
              .orderBy('updatedAt', descending: true)
              .get();

      final notesList =
          notes.docs.map((e) => NotesModel.fromDocument(e.data())).toList();
      return notesList;
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<String> updateNotes(String notesId, String title, String text) async {
    final currentUser = _auth.currentUser;

    try {
      await _firestore
          .collection('users')
          .doc(currentUser!.uid)
          .collection('notes')
          .doc(notesId)
          .update({'title': title, 'text': text, 'updatedAt': DateTime.now()});

      return 'Notes updated successfully';
    } on FirebaseException catch (e) {
      return e.message.toString();
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Future<NotesModel> getNotesById(String notesId) async {
    try {
      final currentUser = _auth.currentUser;
      final notes =
          await _firestore
              .collection('users')
              .doc(currentUser!.uid)
              .collection('notes')
              .doc('${currentUser.uid}$notesId')
              .get();

      final note = NotesModel.fromDocument(
        notes.data() as Map<String, dynamic>,
      );
      return note;
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      throw e.toString();
    }
  }

  factory FirebaseFirestoreServiceImpl.create() {
    return FirebaseFirestoreServiceImpl(
      firestore: FirebaseFirestore.instance,
      auth: FirebaseAuth.instance,
    );
  }
}
