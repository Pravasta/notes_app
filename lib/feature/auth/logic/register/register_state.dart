part of 'register_cubit.dart';

class RegisterState {
  final String message;
  final GlobalState status;

  const RegisterState({this.message = '', this.status = GlobalState.initial});

  RegisterState copyWith({String? message, GlobalState? status}) {
    return RegisterState(
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }
}
