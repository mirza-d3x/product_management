import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:techwarelab/constants/images_assets.dart';
import 'package:techwarelab/app/features/authentication/cubit/auth_cubit.dart';
import 'package:techwarelab/app/widgets/custom_elevated_button.dart';
import 'package:techwarelab/app/widgets/custom_textfield.dart';
import 'package:techwarelab/services/navigation_services/navigation_services.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final AuthenticationCubit cubit =
        BlocProvider.of<AuthenticationCubit>(context);
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthLoaded) {
          context.navigationService.createPinPageRoute(context);
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: size.height,
            width: size.width,
            child: SingleChildScrollView(
              child: Form(
                key: cubit.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    CircleAvatar(
                      minRadius: 66.h,
                      child: Image.asset(ImageAssets.iconTeal),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Login with your Email and \n Password",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28.h,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // Email TextField
                    CustomTextField(
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      label: 'Email',
                      hint: 'Enter your email',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null; // Return null if the input is valid
                      },
                      controller: cubit.emailController,
                    ),
                    SizedBox(height: 20.h), // Spacer
                    // Password TextField
                    CustomTextField(
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null; // Return null if the input is valid
                      },
                      label: 'Passowrd',
                      hint: 'Enter Your Password',
                      controller: cubit.passwordController,
                    ),
                    SizedBox(
                      height: 56.h,
                    ),
                    BlocBuilder<AuthenticationCubit, AuthenticationState>(
                      builder: (context, state) {
                        if (state is AuthLoading) {
                          return SizedBox(
                            height: 53.h,
                            width: size.width,
                            child: CustomElevatedButton(
                              onPressed: () {},
                              textColor: Colors.white,
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          );
                        }
                        return SizedBox(
                          height: 53.h,
                          width: size.width,
                          child: CustomElevatedButton(
                            onPressed: () {
                              if (cubit.formKey.currentState!.validate()) {
                                cubit.loginWithEmail();
                              }
                            },
                            textColor: Colors.white,
                            child: const Text(
                              "Log in",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    TextButton(
                      onPressed: () {
                        context.navigationService
                            .createSignUpPageRoute(context);
                      },
                      child: const Text("Don't have an account?"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
