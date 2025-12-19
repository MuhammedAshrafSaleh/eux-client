// lib/features/auth/cubit/auth_cubit.dart
import 'package:eux_client/common/network/network_info.dart';
import 'package:eux_client/features/auth/data/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;
  final NetworkInfo networkInfo;

  AuthCubit({required this.authRepository, required this.networkInfo})
    : super(AuthInitial());

  // Check if user is already logged in (for splash screen)
  Future<void> checkAuthStatus() async {
    emit(AuthLoading());

    try {
      final isConnected = await networkInfo.isConnected;

      if (!isConnected) {
        emit(const AuthNoInternet('No internet connection'));
        return;
      }

      if (authRepository.isUserLoggedIn()) {
        final user = await authRepository.currentUser;
        if (user != null) {
          emit(AuthAuthenticated(user));
        } else {
          emit(AuthUnauthenticated());
        }
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  // Register with name, email and password
  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
  }) async {
    emit(AuthLoading());

    try {
      final isConnected = await networkInfo.isConnected;

      if (!isConnected) {
        emit(
          const AuthNoInternet(
            'No internet connection. Please check your network and try again.',
          ),
        );
        return;
      }

      final user = await authRepository.registerWithEmailAndPassword(
        name: name,
        email: email,
        password: password,
        phoneNumber: phoneNumber,
      );

      emit(AuthRegisterSuccess(user));
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  // Login with email and password
  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());

    try {
      final isConnected = await networkInfo.isConnected;

      if (!isConnected) {
        emit(
          const AuthNoInternet(
            'No internet connection. Please check your network and try again.',
          ),
        );
        return;
      }

      final user = await authRepository.loginWithEmailAndPassword(
        email: email,
        password: password,
      );

      emit(AuthLoginSuccess(user));
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  // Reset password
  Future<void> resetPassword({required String email}) async {
    emit(AuthLoading());

    try {
      final isConnected = await networkInfo.isConnected;

      if (!isConnected) {
        emit(
          const AuthNoInternet(
            'No internet connection. Please check your network and try again.',
          ),
        );
        return;
      }

      await authRepository.resetPassword(email: email);

      emit(
        const AuthPasswordResetSuccess(
          'Password reset email sent. Please check your inbox.',
        ),
      );
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  // Sign out
  Future<void> signOut() async {
    emit(AuthLoading());

    try {
      await authRepository.signOut();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  // Reset to initial state
  void reset() {
    emit(AuthInitial());
  }
}
