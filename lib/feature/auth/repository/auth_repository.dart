import 'package:notes_app/core/repositories/user_model.dart';
import 'package:notes_app/core/service/firebase_service.dart';

abstract class AuthRepository {
  Future<UserModel> signInWithEmailAndPassword(String email, String password);
  Future<String> signUpWithEmailAndPassword(
    String userName,
    String email,
    String password,
  );
  Future<String> signOut();
}

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseService _firebaseService;

  AuthRepositoryImpl({required FirebaseService firebaseService})
    : _firebaseService = firebaseService;

  @override
  Future<UserModel> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final user = await _firebaseService.singInWithEmailAndPassword(
        email,
        password,
      );
      return user;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<String> signOut() async {
    try {
      final result = await _firebaseService.signOut();
      return result;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<String> signUpWithEmailAndPassword(
    String userName,
    String email,
    String password,
  ) async {
    try {
      final result = await _firebaseService.singUpWithEmailAndPassword(
        userName,
        email,
        password,
      );
      return result;
    } catch (e) {
      throw e.toString();
    }
  }

  factory AuthRepositoryImpl.create() {
    return AuthRepositoryImpl(firebaseService: FirebaseServiceImpl.create());
  }
}
