part of 'pin_cubit.dart';

@immutable
sealed class PinState {}

final class PinInitial extends PinState {
  final String pin;

  PinInitial({required this.pin});
}

final class PinSetupCompleted extends PinState {
  final String pin;

  PinSetupCompleted({required this.pin});
}

final class PinConfirm extends PinState {
  final String pin;
  final String confirmPin;

  PinConfirm({required this.pin, required this.confirmPin});
}

final class PinCheck extends PinState {
  final bool status;

  PinCheck({required this.status});
}
