import 'package:equatable/equatable.dart';
import 'package:eux_client/features/auth/data/user_model.dart';

// Base Auth State
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

// Initial state
class AuthInitial extends AuthState {}

// Loading state
class AuthLoading extends AuthState {}

// Authenticated state
class AuthAuthenticated extends AuthState {
  final UserModel user;

  const AuthAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

// Unauthenticated state
class AuthUnauthenticated extends AuthState {}

// Success states for specific operations
class AuthRegisterSuccess extends AuthState {
  final UserModel user;

  const AuthRegisterSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthLoginSuccess extends AuthState {
  final UserModel user;

  const AuthLoginSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthPasswordResetSuccess extends AuthState {
  final String message;

  const AuthPasswordResetSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

// Error state
class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

// No internet connection state
class AuthNoInternet extends AuthState {
  final String message;

  const AuthNoInternet(this.message);

  @override
  List<Object?> get props => [message];
}
