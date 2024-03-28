// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../constants/Exceptions/app_exceptions.dart';
import '../../../../constants/Keys/secured_storage_key.dart';
import '../../../../services/local_data/secured_storage/secured_storage.dart';
import '../../../../utils/console_log.dart';

part 'pin_event.dart';
part 'pin_state.dart';

class PinBloc extends Bloc<PinEvent, PinState> {
  PinBloc() : super(PinInitialState(pin: "")) {
    on<PinEntered>(_onPinEntered);
    on<PinClear>(_onPinClear);
    on<PinConfirm>(_onPinConfirm);
    on<PinCheck>(_onPinCheck);

    _init();
  }

  String enteredPin = "";
  String confirmPin = "";
  String storedPin = "";
  late final SecuredStorage securedStorage;

  void _init() {
    securedStorage = SecuredStorage();
    _getPinFromSecuredStorage();
  }

  Future<void> _getPinFromSecuredStorage() async {
    try {
      storedPin = await securedStorage.get(SecuredStorageKeys().pinKey) ?? "";

      consoleLog("Stored pin is $storedPin");
      emit(PinSetupCompleted(pin: enteredPin));
    } on SecureStorageException catch (error, stackTrace) {
      consoleLog("Error while getting data from secured storage: ",
          error: error, stackTrace: stackTrace);
      throw SecureStorageException(error.message);
    }
  }

  Future<void> _savePin() async {
    try {
      await securedStorage.save(
          key: SecuredStorageKeys().pinKey, value: confirmPin);
      consoleLog("Pin Saved to Secured Storage");
      emit(PinSetupCompleted(pin: enteredPin));
    } on SecureStorageException catch (error, stackTrace) {
      consoleLog("Error saving pin to secure storage: ",
          error: error, stackTrace: stackTrace);
      throw SecureStorageException(error.message);
    }
  }

  void _onPinEntered(PinEntered event, Emitter<PinState> emit) async {
    if (storedPin.isNotEmpty) {
      // Check mode
      enteredPin += event.digit;
      emit(PinSetupCompleted(pin: enteredPin));
    } else if (enteredPin.length < 4) {
      enteredPin += event.digit;
      // Setup mode

      if (enteredPin.length == 4) {
        emit(PinConfirmState(pin: enteredPin, confirmPin: confirmPin));
      } else {
        emit(PinInitial(pin: enteredPin));
      }
    } else if (enteredPin.length == 4 && confirmPin.length < 4) {
      confirmPin += event.digit;
      emit(PinConfirmState(pin: enteredPin, confirmPin: confirmPin));
    }
  }

  void _onPinClear(PinClear event, Emitter<PinState> emit) async {
    if (storedPin.isNotEmpty) {
      // Check Mode
      enteredPin = enteredPin.substring(0, enteredPin.length - 1);
      emit(PinSetupCompleted(pin: enteredPin));
    } else {
      // Setup Mode
      if (confirmPin.isEmpty) {
        enteredPin = enteredPin.substring(0, enteredPin.length - 1);
        emit(PinSetupState(pin: enteredPin));
      } else {
        confirmPin = confirmPin.substring(0, confirmPin.length - 1);
        emit(PinConfirmState(pin: enteredPin, confirmPin: confirmPin));
      }
    }
  }

  void _onPinConfirm(PinConfirm event, Emitter<PinState> emit) async {
    if (enteredPin == confirmPin) {
      await _savePin();
      emit(PinCheckSuccessState());
    } else {
      enteredPin = "";
      confirmPin = "";
      emit(PinInitialState(pin: enteredPin));
    }
  }

  void _onPinCheck(PinCheck event, Emitter<PinState> emit) {
    if (enteredPin == storedPin) {
      emit(PinCheckSuccessState());
    } else {
      enteredPin = "";
      emit(PinCheckFailureState());
      emit(PinSetupCompleted(pin: enteredPin));
    }
  }
}
