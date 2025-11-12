import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_register_app/core/constants/app_colors.dart';
import 'package:login_register_app/features/profile/bloc/profile_bloc.dart';
import 'package:login_register_app/features/profile/bloc/profile_event.dart';
import 'package:login_register_app/features/profile/bloc/profile_state.dart';

import '../../core/constants/loading_overlay.dart';

class ProfileScreen extends StatelessWidget {
  final String email;

  const ProfileScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBgColor,
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileFailureState) {
            final isNoInternet = state.errorMsg.toLowerCase().contains(
              "no internet",
            );

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isNoInternet ? Icons.wifi_off : Icons.error,
                    color: isNoInternet ? Colors.orange : Colors.red,
                    size: 48,
                  ),
                  SizedBox(height: 16),
                  Text(
                    isNoInternet ? "No Internet Connection" : "Error",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isNoInternet ? Colors.orange : Colors.red,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    isNoInternet
                        ? "Please check your internet connection and try again."
                        : state.errorMsg,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 16),
                  if (isNoInternet) ...[
                    Icon(Icons.wifi, size: 32, color: Colors.grey),
                    SizedBox(height: 8),
                    Text(
                      "Make sure Wi-Fi or mobile data is turned on",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ],
              ),
            );
          }
          if (state is ProfileSuccessState) {
            final userData = state.userData;
            return Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Email: $email",
                        style: TextStyle(color: Colors.black),
                      ),
                      Text('${userData!['message']}'),
                      ElevatedButton(
                        onPressed: () => context.read<ProfileBloc>().add(
                          FetchProfileDataEvent(),
                        ),
                        child: Text('Fetch Data'),
                      ),
                    ],
                  ),
                ),

                // if (state is ProfileLoadingState) buildLoadingOverlay(),
              ],
            );
          }
          return Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Email : $email",
                      style: TextStyle(color: Colors.black),
                    ),
                    ElevatedButton(
                      onPressed: () => context.read<ProfileBloc>().add(
                        FetchProfileDataEvent(),
                      ),
                      child: Text('Fetch Data'),
                    ),
                  ],
                ),
              ),
              if (state is ProfileLoadingState) buildLoadingOverlay(),
            ],
          );
        },
      ),
    );
  }
}
