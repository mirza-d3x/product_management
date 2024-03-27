// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:techwarelab/services/cloud_services/firebase/authentication/auth_services.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial(isUserLoggedIn: false));

  final FirebaseAuthServices _auth = FirebaseAuthServices();

  void checkUserLoged() async {
    final bool isLogged = await _auth.isLoggedIn();
    emit(SplashInitial(isUserLoggedIn: isLogged));
  }

  void checkUserPinSet() {}
}
