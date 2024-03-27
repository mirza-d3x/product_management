import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techwarelab/app/features/pin/cubit/pin_cubit.dart';
import 'package:techwarelab/app/features/pin/ui/pin_screen.dart';

class PinRouteBuilder {
  Widget call(BuildContext context) {
    return BlocProvider(
      create: (context) => PinCubit(),
      child: const PinScreen(),
    );
  }
}
