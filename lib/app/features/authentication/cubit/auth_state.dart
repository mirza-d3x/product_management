part of 'auth_cubit.dart';

@immutable
sealed class AuthenticationState {}

final class AuhtInitial extends AuthenticationState {}

final class AuthLoaded extends AuthenticationState {
  final UserEntity userEntity;

  AuthLoaded({required this.userEntity});
}

final class AuthLoading extends AuthenticationState {}

final class AuthError extends AuthenticationState {
  final String message;

  AuthError(this.message);
}

final class UserLoggedOut extends AuthenticationState {}
