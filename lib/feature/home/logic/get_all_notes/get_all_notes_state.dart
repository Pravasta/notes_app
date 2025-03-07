part of 'get_all_notes_cubit.dart';

enum GetAllNotesStatus { initial, loading, success, error }

class GetAllNotesState {
  final String message;
  final GetAllNotesStatus status;
  final List<NotesModel> notes;

  GetAllNotesState({
    this.message = '',
    this.status = GetAllNotesStatus.initial,
    this.notes = const [],
  });

  GetAllNotesState copyWith({
    String? message,
    GetAllNotesStatus? status,
    List<NotesModel>? notes,
  }) {
    return GetAllNotesState(
      message: message ?? this.message,
      status: status ?? this.status,
      notes: notes ?? this.notes,
    );
  }
}
