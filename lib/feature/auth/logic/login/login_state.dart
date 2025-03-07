part of 'login_cubit.dart';

class LoginState {
  final String message;
  final GlobalState status;
  final UserModel? user;

  const LoginState({
    this.message = '',
    this.status = GlobalState.initial,
    this.user,
  });

  LoginState copyWith({String? message, GlobalState? status, UserModel? user}) {
    return LoginState(
      message: message ?? this.message,
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }
}
