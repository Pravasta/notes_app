import 'package:notes_app/core/repositories/notes_model.dart';
import 'package:notes_app/core/service/firebase_firestore_service.dart';

abstract class NotesRepository {
  Future<String> addNotes(String notesId, String title, String text);
  Future<String> deleteNotes(String id);
  Future<String> updateNotes(String notesId, String title, String text);
  Future<NotesModel> getNotesById(String notesId);
}

class NotesRepositoryImpl implements NotesRepository {
  final FirebaseFirestoreService _firebaseFirestoreService;

  NotesRepositoryImpl({
    required FirebaseFirestoreService firebaseFirestoreService,
  }) : _firebaseFirestoreService = firebaseFirestoreService;

  @override
  Future<String> addNotes(String notesId, String title, String text) async {
    try {
      final result = await _firebaseFirestoreService.addNotes(
        notesId,
        title,
        text,
      );
      return result;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<String> deleteNotes(String id) async {
    try {
      final result = await _firebaseFirestoreService.deleteNotes(id);
      return result;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<NotesModel> getNotesById(String notesId) async {
    try {
      final result = await _firebaseFirestoreService.getNotesById(notesId);
      return result;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<String> updateNotes(String notesId, String title, String text) async {
    try {
      final result = await _firebaseFirestoreService.updateNotes(
        notesId,
        title,
        text,
      );
      return result;
    } catch (e) {
      throw e.toString();
    }
  }

  factory NotesRepositoryImpl.create() {
    return NotesRepositoryImpl(
      firebaseFirestoreService: FirebaseFirestoreServiceImpl.create(),
    );
  }
}
