part of 'auth_cubit.dart';

@immutable
sealed class AuthState  {}

final class AuthInitial extends AuthState {}
final class AuthLoading extends AuthState {}
final class AuthSuccess extends AuthState {
  final String message;
  AuthSuccess({required this.message});
}
final class AuthFailure extends AuthState {
  final String message;
  AuthFailure({required this.message});
}
final class AuthLogoutSuccess extends AuthState {
  final String message;
  AuthLogoutSuccess({required this.message});
}
final class AuthLogoutFailure extends AuthState {
  final String message;
  AuthLogoutFailure({required this.message});
}
