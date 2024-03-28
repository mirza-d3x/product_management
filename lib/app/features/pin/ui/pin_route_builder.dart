import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techwarelab/app/features/pin/bloc/pin_bloc.dart';
import 'package:techwarelab/app/features/pin/ui/pin_screen.dart';

class PinRouteBuilder {
  Widget call(BuildContext context) {
    return BlocProvider(
      create: (context) => PinBloc(),
      child: const PinScreen(),
    );
  }
}
