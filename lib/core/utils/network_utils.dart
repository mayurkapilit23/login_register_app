// utils/network_utils.dart
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class NetworkUtils {
  static Future<bool> isConnected() async {
   
    final connectivityResult = await Connectivity().checkConnectivity();
    // return connectivityResult != ConnectivityResult.none;
    return connectivityResult != ConnectivityResult.none;
  }

  static Future<String> getConnectionType() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult.toString();
  }
}
