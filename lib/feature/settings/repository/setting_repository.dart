import 'package:notes_app/core/repositories/user_model.dart';

import '../../../core/service/firebase_auth_service.dart';

abstract class SettingRepository {
  Future<void> signOut();
  Future<UserModel> getCurrentUser();
}

class SettingRepositoryImpl implements SettingRepository {
  final FirebaseAuthService _firebaseAuthService;

  SettingRepositoryImpl({required FirebaseAuthService firebaseAuthService})
    : _firebaseAuthService = firebaseAuthService;

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuthService.signOut();
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<UserModel> getCurrentUser() async {
    try {
      final result = await _firebaseAuthService.getCurrentUser();
      return result;
    } catch (e) {
      throw e.toString();
    }
  }

  factory SettingRepositoryImpl.create() {
    return SettingRepositoryImpl(
      firebaseAuthService: FirebaseAuthServiceImpl.create(),
    );
  }
}
