import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/feature/notes/repository/notes_repository.dart';

part 'add_notes_state.dart';

class AddNotesCubit extends Cubit<AddNotesState> {
  AddNotesCubit(this._repository) : super(AddNotesState());

  final NotesRepository _repository;

  void addNotes(String notesId, String title, String text) async {
    emit(state.copyWith(status: AddNotesStatus.loading));
    try {
      final result = await _repository.addNotes(notesId, title, text);
      emit(state.copyWith(status: AddNotesStatus.success, message: result));
    } catch (e) {
      emit(state.copyWith(status: AddNotesStatus.error, message: e.toString()));
    }
  }

  void updateNotes(String notesId, String title, String text) async {
    emit(state.copyWith(status: AddNotesStatus.loading));
    try {
      final result = await _repository.updateNotes(notesId, title, text);
      emit(state.copyWith(status: AddNotesStatus.success, message: result));
    } catch (e) {
      emit(state.copyWith(status: AddNotesStatus.error, message: e.toString()));
    }
  }
}
