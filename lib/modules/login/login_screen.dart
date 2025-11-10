import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_register_app/modules/home/home_screen.dart';
import 'package:login_register_app/modules/login/bloc/login_bloc.dart';
import 'package:login_register_app/modules/login/bloc/login_event.dart';
import 'package:login_register_app/modules/login/bloc/login_state.dart';
import 'package:login_register_app/widgets/custom_button.dart';
import 'package:login_register_app/widgets/custom_textfield.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();

  void _onLoginPressed(BuildContext context) {
    FocusScope.of(context).unfocus(); // 👈 hides the keyboard
    final email = emailEditingController.text.trim();
    final password = passwordEditingController.text.trim();

    context.read<LoginBloc>().add(
      LoginSubmitEvent(email: email, password: password),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF0F0F0),
      // backgroundColor: AppColors.primary,
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text("Login Successfully")));

            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => HomeScreen(email: state.email),
              ),
            );
          } else if (state is LoginErrorState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
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
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Email',
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                      ),

                      const SizedBox(height: 2),
                      CustomTextField(
                        controller: emailEditingController,
                        hint: 'example200@gmail.com',
                      ),
                      const SizedBox(height: 20),

                      // Password field
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Password',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 2),
                      CustomTextField(
                        obscureText: state is ObscureButtonState
                            ? state.isObscure
                            : true,
                        controller: passwordEditingController,
                        hint: '************',
                        suffixIcon: IconButton(
                          onPressed: () {
                            context.read<LoginBloc>().add(ObscureButtonEvent());
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
                            'Forgot Password?',
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
                        onPressed: () => _onLoginPressed(context),
                      ),
                      const SizedBox(height: 20),
                      const Align(
                        alignment: Alignment.center,
                        child: Text('or'),
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.center,
                        child: IconButton(
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () {},
                          icon: Icon(Icons.apple),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ✅ Centered Lottie Loading Overlay
              if (state is LoginLoadingState)
                Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: Lottie.asset(
                      'assets/Wind.json',
                      height: 150,
                      width: 150,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
