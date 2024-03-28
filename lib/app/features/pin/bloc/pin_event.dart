part of 'pin_bloc.dart';

@immutable
sealed class PinEvent {}

class PinEntered extends PinEvent {
  final String digit;
  PinEntered(this.digit);
}

class PinClear extends PinEvent {}

class PinConfirm extends PinEvent {}

class PinCheck extends PinEvent {}
