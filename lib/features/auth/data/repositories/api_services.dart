import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/utils/network_utils.dart';

class ApiServices {
  static const BASE_URL = 'http://10.160.45.136:3000';

  Future<Map<String, dynamic>> userRegister(
    String email,
    String password,
  ) async {
    final url = Uri.parse("$BASE_URL/register");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );
    // Check internet connection first
    if (!await NetworkUtils.isConnected()) {
      throw Exception("No internet connection");
    }
    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 400) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to create account !!!");
    }
  }

  Future<Map<String, dynamic>> userLogin(String email, String password) async {
    final url = Uri.parse("$BASE_URL/login");
    // Check internet connection first
    if (!await NetworkUtils.isConnected()) {
      throw Exception("No internet connection");
    }

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 400) {
      return jsonDecode(response.body);
    } else {
      final body = jsonDecode(response.body);
      throw Exception(body['message'] ?? "Failed to login to account !!!");
    }
  }

  Future<Map<String, dynamic>?> showServerResponse() async {
    // Check internet connection first
    if (!await NetworkUtils.isConnected()) {
      throw Exception("No internet connection");
    }
    try {
      final response = await http.get(Uri.parse("$BASE_URL/profile"));
      if (response.statusCode == 200) {
        final data = json.decode(response.body); // decode JSON into List/Map
        print(data);
        return data;
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
    return null;
  }
}
