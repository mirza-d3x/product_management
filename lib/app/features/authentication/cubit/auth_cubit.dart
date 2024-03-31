import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:techwarelab/constants/Keys/secured_storage_key.dart';
import 'package:techwarelab/domain/entities/users/users.dart';
import 'package:techwarelab/domain/use_cases/user/signup_use_cases.dart';
import 'package:techwarelab/services/cloud_services/firebase/authentication/auth_services.dart';
import 'package:techwarelab/services/local_data/secured_storage/secured_storage.dart';
import 'package:techwarelab/utils/console_log.dart';

import '../../../../constants/Exceptions/app_exceptions.dart';
import '../../../../domain/use_cases/user/login_use_case.dart';

part 'auth_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit(this._loginUserUseCase, this._signUpUserUseCase)
      : super(AuhtInitial()) {
    init();
  }

  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final FirebaseAuthServices _authentication;
  late final GlobalKey<FormState> formKey;

  final LoginUserUseCase _loginUserUseCase;
  final SignUpUserUseCase _signUpUserUseCase;
  void init() {
    consoleLog("initializing login cubit");
    emailController = TextEditingController();
    passwordController = TextEditingController();
    _authentication = FirebaseAuthServices();
    formKey = GlobalKey<FormState>();
  }

  Future<void> loginWithEmail() async {
    emit(AuthLoading());
    try {
      final user = await _loginUserUseCase(
          emailController.text, passwordController.text);
      emit(AuthLoaded(userEntity: user));
    } on UserNotFoundException {
      emit(AuthError('User not found'));
    } on GenericAuthException {
      emit(AuthError('Something went wrong. Please try again.'));
    }
  }

  void signUpWithEmai() async {
    try {
      emit(AuthLoading());
      consoleLog(
          "Signup with email:${emailController.text} password: ${passwordController.text}");
      final user = await _signUpUserUseCase(
          emailController.text, passwordController.text);
      consoleLog("response_body: ");
      emit(AuthLoaded(userEntity: user));
    } on UserNotFoundException {
      emit(AuthError('User not found'));
    } on GenericAuthException {
      emit(AuthError('Something went wrong. Please try again.'));
    } catch (error, stackTrace) {
      consoleLog("error while sign up: ", error: error, stackTrace: stackTrace);
    }
  }

  void logOutUser() async {
    try {
      emit(AuthLoading());
      SecuredStorage securedStorage = SecuredStorage();
      await _authentication.signOut();
      await securedStorage.delete(SecuredStorageKeys().pinKey);
      emit(UserLoggedOut());
    } catch (error, stackTrace) {
      consoleLog("Error while logging out: ",
          error: error, stackTrace: stackTrace);
    }
  }

  @override
  Future<void> close() {
    consoleLog("closing login cubit");
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
