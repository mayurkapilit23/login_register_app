import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_register_app/core/constants/app_colors.dart';
import 'package:login_register_app/core/constants/loading_overlay.dart';
import 'package:login_register_app/core/widgets/custom_button.dart';
import 'package:login_register_app/core/widgets/custom_textfield.dart';
import 'package:login_register_app/features/auth/bloc/auth_bloc.dart';
import 'package:login_register_app/features/auth/bloc/auth_event.dart';
import 'package:login_register_app/features/auth/bloc/auth_state.dart';
import 'package:login_register_app/features/auth/screens/register_screen.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../profile/profile_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBgColor,
      // backgroundColor: AppColors.primary,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccessState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));

            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProfileScreen(email: state.message),
              ),
            );
          } else if (state is AuthErrorState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          } else if (state is AuthNavigateToRegisterState) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => RegisterScreen()),
            );
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              // Main content
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 100),
                      Text(
                        'Welcome Back!',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 30,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Sign in to continue your journey',
                        style: TextStyle(
                          // fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Email field
                      CustomTextField(
                        controller: emailEditingController,
                        hint: 'Email Address',
                      ),
                      const SizedBox(height: 20),

                      // Password field
                      CustomTextField(
                        obscureText: state is ObscureButtonState
                            ? state.isObscure
                            : true,
                        controller: passwordEditingController,
                        hint: 'Password',
                        suffixIcon: IconButton(
                          onPressed: () {
                            context.read<AuthBloc>().add(ObscureButtonEvent());
                          },
                          icon: state is ObscureButtonState && !state.isObscure
                              ? const Icon(Icons.visibility_outlined)
                              : const Icon(Icons.visibility_off_outlined),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Forgot Password
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () => print("forgot password"),
                          child: Text(
                            'Forgot your password?',
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Login Button
                      CustomButton(
                        text: "Sign in",
                        onPressed: () {
                          context.read<AuthBloc>().add(
                            LoginUserEvent(
                              emailEditingController.text.trim(),
                              passwordEditingController.text.trim(),
                            ),
                          );
                          emailEditingController.clear();
                          passwordEditingController.clear();
                        },
                      ),
                      const SizedBox(height: 20),
                      const Align(
                        alignment: Alignment.center,
                        child: Text('or'),
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () {},
                          child: Icon(Symbols.google_home_devices),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Text('Don\'t have an account?'),
                          TextButton(
                            onPressed: () => context.read<AuthBloc>().add(
                              NavigateToRegisterEvent(),
                            ),
                            child: Text(
                              'Sign Up',

                              style: TextStyle(color: Colors.indigo),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              //  Centered Lottie Loading Overlay
              if (state is AuthLoadingState) buildLoadingOverlay(),
            ],
          );
        },
      ),
    );
  }
}
