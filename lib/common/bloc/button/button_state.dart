part of 'button_cubit.dart';

@immutable
sealed class ButtonState {}

final class ButtonInitial extends ButtonState {}

final class ButtonLoadingState extends ButtonState {}

final class ButtonSuccessfulState extends ButtonState {}

final class ButtonFailureState extends ButtonState {}
