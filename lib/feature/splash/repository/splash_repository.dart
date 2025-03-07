import 'package:notes_app/core/service/firebase_service.dart';

abstract class SplashRepository {
  Future<bool> isUserLoggedIn();
}

class SplashRepositoryImpl implements SplashRepository {
  final FirebaseService _firebaseService;

  SplashRepositoryImpl({required FirebaseService firebaseService})
    : _firebaseService = firebaseService;

  @override
  Future<bool> isUserLoggedIn() async {
    try {
      final result = await _firebaseService.isUserLoggedIn();
      return result;
    } catch (e) {
      throw e.toString();
    }
  }

  factory SplashRepositoryImpl.create() {
    return SplashRepositoryImpl(firebaseService: FirebaseServiceImpl.create());
  }
}
