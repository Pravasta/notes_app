part of 'delete_notes_cubit.dart';

enum DeleteNotesStatus { initial, loading, success, error }

class DeleteNotesState {
  final String message;
  final DeleteNotesStatus status;

  DeleteNotesState({
    this.message = '',
    this.status = DeleteNotesStatus.initial,
  });

  DeleteNotesState copyWith({String? message, DeleteNotesStatus? status}) {
    return DeleteNotesState(
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }
}
