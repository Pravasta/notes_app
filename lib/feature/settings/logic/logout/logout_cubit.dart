import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/feature/settings/repository/setting_repository.dart';

import '../../../../core/utils/global_state.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit(this._repository) : super(LogoutState());

  final SettingRepository _repository;

  void logout() async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      await _repository.signOut();
      emit(state.copyWith(status: GlobalState.loaded));
    } catch (e) {
      emit(state.copyWith(message: e.toString(), status: GlobalState.failed));
    }
  }
}
