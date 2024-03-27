import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techwarelab/app/features/authentication/cubit/auth_cubit.dart';
import 'package:techwarelab/app/features/authentication/ui/signup_screen.dart';

import '../../../../domain/use_cases/user/login_use_case.dart';
import '../../../../domain/use_cases/user/signup_use_cases.dart';
import '../../../../services/cloud_services/firebase/authentication/auth_services.dart';

class SignupRouteBuilder {
  Widget call(BuildContext context) {
    final FirebaseAuthServices _authService = FirebaseAuthServices();
    return BlocProvider(
      create: (context) => AuthenticationCubit(
          LoginUserUseCase(_authService), SignUpUserUseCase(_authService)),
      child: const SignupScreen(),
    );
  }
}
