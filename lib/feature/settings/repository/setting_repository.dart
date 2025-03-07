import 'package:notes_app/core/repositories/user_model.dart';

import '../../../core/service/firebase_service.dart';

abstract class SettingRepository {
  Future<void> signOut();
  Future<UserModel> getCurrentUser();
}

class SettingRepositoryImpl implements SettingRepository {
  final FirebaseService _firebaseService;

  SettingRepositoryImpl({required FirebaseService firebaseService})
    : _firebaseService = firebaseService;

  @override
  Future<void> signOut() async {
    try {
      await _firebaseService.signOut();
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<UserModel> getCurrentUser() async {
    try {
      final result = await _firebaseService.getCurrentUser();
      return result;
    } catch (e) {
      throw e.toString();
    }
  }

  factory SettingRepositoryImpl.create() {
    return SettingRepositoryImpl(firebaseService: FirebaseServiceImpl.create());
  }
}
