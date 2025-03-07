import 'package:notes_app/core/repositories/user_model.dart';
import 'package:notes_app/core/service/firebase_auth_service.dart';

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
  final FirebaseAuthService _firebaseAuthService;

  AuthRepositoryImpl({required FirebaseAuthService firebaseAuthService})
    : _firebaseAuthService = firebaseAuthService;

  @override
  Future<UserModel> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final user = await _firebaseAuthService.singInWithEmailAndPassword(
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
      final result = await _firebaseAuthService.signOut();
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
      final result = await _firebaseAuthService.singUpWithEmailAndPassword(
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
    return AuthRepositoryImpl(
      firebaseAuthService: FirebaseAuthServiceImpl.create(),
    );
  }
}
