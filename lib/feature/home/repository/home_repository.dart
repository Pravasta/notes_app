import 'package:notes_app/core/repositories/notes_model.dart';
import 'package:notes_app/core/service/firebase_firestore_service.dart';

abstract class HomeRepository {
  Future<List<NotesModel>> getNotes();
}

class HomeRepositoryImpl implements HomeRepository {
  final FirebaseFirestoreService _firebaseFirestoreService;

  HomeRepositoryImpl({
    required FirebaseFirestoreService firebaseFirestoreService,
  }) : _firebaseFirestoreService = firebaseFirestoreService;

  @override
  Future<List<NotesModel>> getNotes() async {
    try {
      final result = await _firebaseFirestoreService.getNotes();
      return result;
    } catch (e) {
      throw e.toString();
    }
  }

  factory HomeRepositoryImpl.create() {
    return HomeRepositoryImpl(
      firebaseFirestoreService: FirebaseFirestoreServiceImpl.create(),
    );
  }
}
