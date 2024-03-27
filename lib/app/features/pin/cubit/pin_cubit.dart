import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:techwarelab/constants/Exceptions/app_exceptions.dart';
import 'package:techwarelab/constants/Keys/secured_storage_key.dart';
import 'package:techwarelab/services/local_data/secured_storage/secured_storage.dart';
import 'package:techwarelab/utils/console_log.dart';

part 'pin_state.dart';

class PinCubit extends Cubit<PinState> {
  PinCubit() : super(PinInitial(pin: "")) {
    init();
  }

  String enteredPin = "";
  String confirmPin = "";
  String storedPin = "";
  late final SecuredStorage securedStorage;
  void init() {
    securedStorage = SecuredStorage();
    getPinFromSecuredStorage();
  }

  Future<bool> checkPinSeted() async {
    return storedPin.isNotEmpty;
  }

  getPinFromSecuredStorage() async {
    try {
      storedPin = await securedStorage.get(SecuredStorageKeys().pinKey) ?? "";
      consoleLog("Stored pin is $storedPin");
      emit(PinSetupCompleted(pin: ""));
    } on SecureStorageException catch (error, stackTrace) {
      consoleLog("Error while getting data from secured storage: ",
          error: error, stackTrace: stackTrace);
      throw SecureStorageException(error.message);
    }
  }

  void checkPin() {
    if (storedPin == enteredPin) {
      emit(PinCheck(status: true));
    } else {
      emit(PinCheck(status: false));
      enteredPin = "";
      confirmPin = "";
      emit(PinSetupCompleted(pin: ""));
    }
  }

  void savePin() async {
    try {
      securedStorage.save(key: SecuredStorageKeys().pinKey, value: confirmPin);
      consoleLog("Pin Saved to Secured Storage");
      emit(PinCheck(status: true));
    } on SecureStorageException catch (error, stackTrace) {
      consoleLog("Error saving pin to secure storage: ",
          error: error, stackTrace: stackTrace);
      throw SecureStorageException(error.message);
    }
  }

  void enterPin(String pin) async {
    if (storedPin.isNotEmpty) {
      enteredPin = enteredPin + pin;
      emit(PinSetupCompleted(pin: enteredPin));
    } else if (enteredPin.length < 4) {
      enteredPin = enteredPin + pin;
      if (enteredPin.length == 4) {
        emit(PinConfirm(pin: enteredPin, confirmPin: confirmPin));
      } else {
        emit(PinInitial(pin: enteredPin));
      }
    } else if (enteredPin.length == 4 && confirmPin.length < 4) {
      confirmPin = confirmPin + pin;
      emit(PinConfirm(pin: enteredPin, confirmPin: confirmPin));
    }
  }

  void clearPin() async {
    if (storedPin.isNotEmpty && enteredPin.isNotEmpty) {
      enteredPin = enteredPin.substring(0, enteredPin.length - 1);
      emit(PinSetupCompleted(pin: enteredPin));
    } else if (enteredPin.isNotEmpty &&
        enteredPin.length <= 4 &&
        confirmPin.isEmpty) {
      if (confirmPin.isEmpty && enteredPin.length == 4) {
        enteredPin = "";
      } else {
        enteredPin = enteredPin.substring(0, enteredPin.length - 1);
      }

      emit(PinInitial(pin: enteredPin));
    } else if (confirmPin.isNotEmpty) {
      confirmPin = confirmPin.substring(0, confirmPin.length - 1);
      emit(PinConfirm(pin: enteredPin, confirmPin: confirmPin));
    }
  }
}
