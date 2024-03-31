import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techwarelab/app/features/pin/bloc/pin_bloc.dart';
import 'package:techwarelab/services/navigation_services/navigation_services.dart';

class PinScreen extends StatelessWidget {
  const PinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PIN'),
        centerTitle: true,
      ),
      body: BlocConsumer<PinBloc, PinState>(
        listener: (context, state) {
          if (state is PinCheckSuccessState) {
            // if (state.status) {
            context.navigationService.createProductPageRoute(context);
            // } else {
          } else if (state is PinCheckFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("PINs do not match"),
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is PinInitial) {
            return PinContainer(
              title: 'Set your PIN',
              pin: state.pin,
            );
          } else if (state is PinConfirmState) {
            return PinContainer(
              title: 'Confirm your PIN',
              pin: state.confirmPin,
            );
          } else if (state is PinSetupCompleted) {
            return PinContainer(
              title: 'Enter your PIN',
              pin: state.pin,
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class PinContainer extends StatelessWidget {
  const PinContainer({
    super.key,
    required this.pin,
    required this.title,
  });
  final String pin;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 20.0),
            PinDisplay(pin: pin),
            const SizedBox(height: 20.0),
            PinKeypad(),
          ],
        ),
      ),
    );
  }
}

class PinDisplay extends StatelessWidget {
  final String pin;

  const PinDisplay({super.key, required this.pin});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 1; i <= 4; i++)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            width: 50.0,
            height: 50.0,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Center(
              child: i <= pin.length
                  ? const CircleAvatar(
                      radius: 8.0,
                      backgroundColor: Colors.black,
                    )
                  : null,
            ),
          ),
      ],
    );
  }
}

class PinKeypad extends StatelessWidget {
  final List<int> _digits = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0];

  PinKeypad({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      padding: const EdgeInsets.all(20.0),
      crossAxisSpacing: 10.0,
      mainAxisSpacing: 10.0,
      children: [
        ..._digits.map(
          (digit) => InkWell(
            onTap: () {
              BlocProvider.of<PinBloc>(context)
                  .add(PinEntered(digit.toString()));
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text(
                  '$digit',
                  style: const TextStyle(fontSize: 24.0),
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            BlocProvider.of<PinBloc>(context).add(PinClear());
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Icon(Icons.backspace),
          ),
        ),
        BlocBuilder<PinBloc, PinState>(
          builder: (context, state) {
            if (state is PinConfirm) {
              return InkWell(
                onTap: () {
                  // if (state.confirmPin == state.pin) {
                  BlocProvider.of<PinBloc>(context).add(PinConfirm());
                  // } else {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     const SnackBar(
                  //       content:
                  //           Text("Confirm PINs do not match with Entered Pin"),
                  //       duration: Duration(seconds: 2),
                  //     ),
                  //   );
                  // }
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Icon(Icons.done),
                ),
              );
            } else if (state is PinConfirmState) {
              return InkWell(
                onTap: () {
                  if (BlocProvider.of<PinBloc>(context).enteredPin.isNotEmpty) {
                    BlocProvider.of<PinBloc>(context).add(PinConfirm());
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please Enter Your Pin"),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Icon(Icons.done),
                ),
              );
            } else if (state is PinSetupCompleted) {
              return InkWell(
                onTap: () {
                  if (BlocProvider.of<PinBloc>(context).enteredPin.isNotEmpty) {
                    BlocProvider.of<PinBloc>(context).add(PinCheck());
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please Enter Your Pin"),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Icon(Icons.done),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }
}
