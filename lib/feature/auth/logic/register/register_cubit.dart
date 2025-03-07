import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/core/utils/global_state.dart';
import 'package:notes_app/feature/auth/repository/auth_repository.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this._repository) : super(RegisterState());

  final AuthRepository _repository;

  void register(String userName, String email, String password) async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final result = await _repository.signUpWithEmailAndPassword(
        userName,
        email,
        password,
      );
      emit(state.copyWith(message: result, status: GlobalState.loaded));
    } catch (e) {
      emit(state.copyWith(message: e.toString(), status: GlobalState.failed));
    }
  }
}
