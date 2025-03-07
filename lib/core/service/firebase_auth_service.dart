import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_app/core/exception/app_exception.dart';
import 'package:notes_app/core/repositories/user_model.dart';

abstract class FirebaseAuthService {
  Future<UserModel> singInWithEmailAndPassword(String email, String password);
  Future<String> singUpWithEmailAndPassword(
    String userName,
    String email,
    String password,
  );
  Future<String> signOut();
  Future<UserModel> getCurrentUser();
  Future<void> setUserFirestore(String userName, String uid, String email);
  Future<bool> isUserLoggedIn();
}

class FirebaseAuthServiceImpl implements FirebaseAuthService {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  FirebaseAuthServiceImpl({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
  }) : _auth = auth,
       _firestore = firestore;

  @override
  Future<UserModel> getCurrentUser() async {
    try {
      final currentUser = _auth.currentUser;
      final userData =
          await _firestore.collection('users').doc(currentUser!.uid).get();
      final user = UserModel.fromMap(userData.data() as Map<String, dynamic>);
      return user;
    } on FirebaseException catch (e) {
      throw AppException(e.message.toString()).message;
    } catch (e) {
      throw AppException(e.toString()).message;
    }
  }

  @override
  Future<String> signOut() async {
    try {
      await _auth.signOut();
      return 'Sign out successfully';
    } on FirebaseException catch (e) {
      throw AppException(e.message.toString()).message;
    } catch (e) {
      throw AppException(e.toString()).message;
    }
  }

  @override
  Future<UserModel> singInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final UserModel user = UserModel(
        uid: credential.user!.uid,
        email: credential.user!.email,
      );

      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AppException('No user found for that email.').message;
      } else if (e.code == 'wrong-password') {
        throw AppException('Wrong password provided for that user.').message;
      } else {
        throw AppException('${e.message}').message;
      }
    } catch (e) {
      throw AppException('$e').message;
    }
  }

  @override
  Future<String> singUpWithEmailAndPassword(
    String userName,
    String email,
    String password,
  ) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = UserModel(
        uid: credential.user!.uid,
        email: credential.user!.email,
        name: userName,
      );

      await setUserFirestore(user.name!, user.uid!, user.email!);

      return 'Success create account';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AppException('The password provided is too weak.').message;
      } else if (e.code == 'email-already-in-use') {
        throw AppException(
          'The account already exists for that email.',
        ).message;
      }
      throw AppException(e.message ?? '').message;
    } catch (e) {
      throw AppException(e.toString()).message;
    }
  }

  @override
  Future<void> setUserFirestore(
    String userName,
    String uid,
    String email,
  ) async {
    try {
      await _firestore.collection('users').doc(uid).set({
        'uid': uid,
        'email': email,
        'name': userName,
      });
    } on FirebaseException catch (e) {
      throw AppException(e.message ?? '').message;
    } catch (e) {
      throw AppException(e.toString()).message;
    }
  }

  @override
  Future<bool> isUserLoggedIn() async {
    return _auth.currentUser != null;
  }

  factory FirebaseAuthServiceImpl.create() {
    return FirebaseAuthServiceImpl(
      auth: FirebaseAuth.instance,
      firestore: FirebaseFirestore.instance,
    );
  }
}
