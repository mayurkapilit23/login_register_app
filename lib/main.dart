import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_register_app/features/auth/bloc/auth_bloc.dart';
import 'package:login_register_app/features/onboarding/welcome_screen.dart';
import 'package:login_register_app/features/profile/bloc/profile_bloc.dart';

import 'features/auth/data/repositories/api_services.dart';

void main() {
  final ApiServices apiServices = ApiServices();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc(apiServices)),
        BlocProvider(create: (_) => ProfileBloc(apiServices)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: GoogleFonts.inter().fontFamily),
      home: WelcomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
