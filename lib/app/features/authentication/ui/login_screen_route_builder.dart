import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techwarelab/app/features/authentication/cubit/auth_cubit.dart';
import 'package:techwarelab/app/features/authentication/ui/logn_screen.dart';
import 'package:techwarelab/domain/use_cases/user/login_use_case.dart';
import 'package:techwarelab/domain/use_cases/user/signup_use_cases.dart';
import 'package:techwarelab/services/cloud_services/firebase/auth_services.dart';

class LoginRouteBuilder {
  Widget call(BuildContext context) {
    final FirebaseAuthServices _authService = FirebaseAuthServices();
    return BlocProvider(
      create: (context) => AuthenticationCubit(
          LoginUserUseCase(_authService), SignUpUserUseCase(_authService)),
      child: const LoginScreen(),
    );
  }
}
