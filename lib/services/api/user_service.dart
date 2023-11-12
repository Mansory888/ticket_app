import 'dart:convert';
import 'package:flutter/material.dart';

import '/models/user.dart';
import 'api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> registerUser(Map<String, dynamic> userData) async {
  final response = await postRequest('users/register', userData);

  if (response.statusCode == 201) {
    return response.body;
  } else {
    throw response.body;
  }
}

Future<Map<String, dynamic>> loginUser(Map<String, dynamic> credentials) async {
  final response = await postRequest('users/login', credentials);

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw response.body;
  }
}

// Saving user data
Future<void> persistUserData(
    String token, String username, String email) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('auth_token', token);
  await prefs.setString('username', username);
  await prefs.setString('email', email);
}

// Retrieving user data
Future<Map<String, String?>> getUserData() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('auth_token');
  String? username = prefs.getString('username');
  String? email = prefs.getString('email');

  return {
    'token': token,
    'username': username,
    'email': email,
  };
}

// Checking the token and user data at app startup
Future<bool> checkUserData() async {
  final Map<String, String?> userData = await getUserData();
  final String? token = userData['token'];
  return token != null; // Return true if token exists, false otherwise
}
