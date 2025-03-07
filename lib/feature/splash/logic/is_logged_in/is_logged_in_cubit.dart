import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/feature/splash/repository/splash_repository.dart';

part 'is_logged_in_state.dart';

class IsLoggedInCubit extends Cubit<IsLoggedInState> {
  IsLoggedInCubit(this._repository) : super(IsLoggedInState());
  final SplashRepository _repository;

  void isLoggedIn() async {
    emit(state.copyWith(status: AuthStatus.authenticating));
    try {
      final isLoggedIn = await _repository.isUserLoggedIn();
      if (isLoggedIn) {
        emit(state.copyWith(status: AuthStatus.authenticated));
      } else {
        emit(state.copyWith(status: AuthStatus.unauthenticated));
      }
    } catch (e) {
      emit(
        state.copyWith(
          message: e.toString(),
          status: AuthStatus.unauthenticated,
        ),
      );
    }
  }
}
