part of 'is_logged_in_cubit.dart';

enum AuthStatus { authenticating, authenticated, unauthenticated, initial }

class IsLoggedInState {
  final AuthStatus status;
  final String message;
  final bool isLoggedIn;

  const IsLoggedInState({
    this.status = AuthStatus.initial,
    this.message = '',
    this.isLoggedIn = false,
  });

  IsLoggedInState copyWith({
    AuthStatus? status,
    String? message,
    bool? isLoggedIn,
  }) {
    return IsLoggedInState(
      status: status ?? this.status,
      message: message ?? this.message,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }
}
