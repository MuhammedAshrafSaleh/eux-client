import 'package:eux_client/common/network/network_info.dart';
import 'package:eux_client/features/auth/data/auth_repository.dart';
import 'package:eux_client/features/splash_screen/cubit/splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<SplashState> {
  final AuthRepository authRepository;
  final NetworkInfo networkInfo;
  // Here means when the cubit is built take the displaySplashState
  SplashCubit({required this.authRepository, required this.networkInfo})
    : super(SplashInitial());

  // Check authentication status on splash screen
  Future<void> checkAuthStatus() async {
    emit(SplashLoadingState());

    try {
      // Add a small delay for splash screen effect (optional)
      await Future.delayed(const Duration(seconds: 2));

      // Check internet connection
      if (!await networkInfo.isConnected) {
        // Even without internet, check local auth state
        // Firebase Auth caches the user locally
        if (authRepository.isUserLoggedIn()) {
          emit(SplashAuthenticatedState());
        } else {
          emit(SplashUnAutheticatedState());
        }
        return;
      }

      // Check if user is logged in
      if (authRepository.isUserLoggedIn()) {
        final user = authRepository.currentUser;
        // ignore: unnecessary_null_comparison
        if (user != null) {
          // User is logged in, navigate to home
          emit(SplashAuthenticatedState());
        } else {
          // User is not logged in, navigate to login
          emit(SplashUnAutheticatedState());
        }
      } else {
        // User is not logged in, navigate to login
        emit(SplashUnAutheticatedState());
      }
    } catch (e) {
      emit(SplashError(e.toString()));
      // On error, assume unauthenticated
      emit(SplashUnAutheticatedState());
    }
  }
}
