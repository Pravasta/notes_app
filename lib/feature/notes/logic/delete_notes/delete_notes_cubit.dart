import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/feature/notes/repository/notes_repository.dart';

part 'delete_notes_state.dart';

class DeleteNotesCubit extends Cubit<DeleteNotesState> {
  DeleteNotesCubit(this._repository) : super(DeleteNotesState());

  final NotesRepository _repository;

  void deleteNotes(String id) async {
    emit(state.copyWith(status: DeleteNotesStatus.loading));
    try {
      final result = await _repository.deleteNotes(id);
      emit(state.copyWith(status: DeleteNotesStatus.success, message: result));
    } catch (e) {
      emit(
        state.copyWith(status: DeleteNotesStatus.error, message: e.toString()),
      );
    }
  }
}
