import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/core/repositories/user_model.dart';
import 'package:notes_app/core/utils/global_state.dart';

import '../../repository/auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._repository) : super(LoginState());

  final AuthRepository _repository;

  void login(String email, String password) async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final user = await _repository.signInWithEmailAndPassword(
        email,
        password,
      );
      emit(state.copyWith(user: user, status: GlobalState.loaded));
    } catch (e) {
      emit(state.copyWith(message: e.toString(), status: GlobalState.failed));
    }
  }
}
