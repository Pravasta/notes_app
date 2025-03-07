part of 'add_notes_cubit.dart';

enum AddNotesStatus { initial, loading, success, error }

class AddNotesState {
  final String message;
  final AddNotesStatus status;

  AddNotesState({this.message = '', this.status = AddNotesStatus.initial});

  AddNotesState copyWith({String? message, AddNotesStatus? status}) {
    return AddNotesState(
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }
}
