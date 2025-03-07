import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/feature/home/repository/home_repository.dart';

import '../../../../core/repositories/notes_model.dart';

part 'get_all_notes_state.dart';

class GetAllNotesCubit extends Cubit<GetAllNotesState> {
  GetAllNotesCubit(this._repository) : super(GetAllNotesState());

  final HomeRepository _repository;

  void getAllNotes() async {
    emit(state.copyWith(status: GetAllNotesStatus.loading));
    try {
      final result = await _repository.getNotes();
      emit(state.copyWith(status: GetAllNotesStatus.success, notes: result));
    } catch (e) {
      emit(
        state.copyWith(status: GetAllNotesStatus.error, message: e.toString()),
      );
    }
  }
}
