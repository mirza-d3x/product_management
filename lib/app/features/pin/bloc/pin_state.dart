part of 'pin_bloc.dart';

@immutable
sealed class PinState {}

final class PinInitial extends PinState {
  final String pin;

  PinInitial({required this.pin});
}

class PinInitialState extends PinState {
  final String pin;
  PinInitialState({required this.pin});
}

class PinSetupState extends PinState {
  final String pin;
  PinSetupState({required this.pin});
}

class PinConfirmState extends PinState {
  final String pin;
  final String confirmPin;
  PinConfirmState({required this.pin, required this.confirmPin});
}

final class PinSetupCompleted extends PinState {
  final String pin;

  PinSetupCompleted({required this.pin});
}

class PinCheckSuccessState extends PinState {}

class PinCheckFailureState extends PinState {}
