import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/core/repositories/user_model.dart';
import 'package:notes_app/core/utils/global_state.dart';
import 'package:notes_app/feature/settings/repository/setting_repository.dart';

part 'get_current_user_state.dart';

class GetCurrentUserCubit extends Cubit<GetCurrentUserState> {
  GetCurrentUserCubit(this._repository) : super(GetCurrentUserState());

  final SettingRepository _repository;

  void getCurrentUser() async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final user = await _repository.getCurrentUser();
      emit(state.copyWith(user: user, status: GlobalState.loaded));
    } catch (e) {
      emit(state.copyWith(message: e.toString(), status: GlobalState.failed));
    }
  }
}
