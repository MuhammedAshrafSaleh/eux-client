import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:eux_client/common/usecase/usecase.dart';
import 'package:meta/meta.dart';

part 'button_state.dart';

class ButtonCubit extends Cubit<ButtonState> {
  ButtonCubit() : super(ButtonInitial());
  Future<void> execute({dynamic params, required Usecase usecase}) async {
    emit(ButtonLoadingState());
    try {
      Either response = await usecase(params: params);
      response.fold(
        (error) {
          emit(ButtonFailureState());
        },
        (data) {
          emit(ButtonSuccessfulState());
        },
      );
    } catch (e) {
      emit(ButtonFailureState());
    }
  }
}
