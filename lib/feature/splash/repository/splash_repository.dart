import 'package:notes_app/core/service/firebase_auth_service.dart';

abstract class SplashRepository {
  Future<bool> isUserLoggedIn();
}

class SplashRepositoryImpl implements SplashRepository {
  final FirebaseAuthService _firebaseAuthService;

  SplashRepositoryImpl({required FirebaseAuthService firebaseAuthService})
    : _firebaseAuthService = firebaseAuthService;

  @override
  Future<bool> isUserLoggedIn() async {
    try {
      final result = await _firebaseAuthService.isUserLoggedIn();
      return result;
    } catch (e) {
      throw e.toString();
    }
  }

  factory SplashRepositoryImpl.create() {
    return SplashRepositoryImpl(
      firebaseAuthService: FirebaseAuthServiceImpl.create(),
    );
  }
}
