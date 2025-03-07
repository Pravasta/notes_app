part of 'get_current_user_cubit.dart';

class GetCurrentUserState {
  final String message;
  final UserModel? user;
  final GlobalState status;

  const GetCurrentUserState({
    this.message = '',
    this.user,
    this.status = GlobalState.initial,
  });

  GetCurrentUserState copyWith({
    String? message,
    UserModel? user,
    GlobalState? status,
  }) {
    return GetCurrentUserState(
      message: message ?? this.message,
      user: user ?? this.user,
      status: status ?? this.status,
    );
  }
}
