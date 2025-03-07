part of 'logout_cubit.dart';

class LogoutState {
  final String message;
  final GlobalState status;

  const LogoutState({this.message = '', this.status = GlobalState.initial});

  LogoutState copyWith({String? message, GlobalState? status}) {
    return LogoutState(
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }
}
