import 'package:eux_client/features/splash_screen/bloc/splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<SplashState> {
  // Here means when the cubit is built take the displaySplashState
  SplashCubit() : super(DisplaySplashState());
  void appStarted() async {
    await Future.delayed(const Duration(seconds: 2));
    emit(UnAutheticatedState());
  }
}
