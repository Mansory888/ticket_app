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
Future<void> persistUserData(String token, String username, String email,
    int languageid, int userId) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('auth_token', token);
  await prefs.setString('username', username);
  await prefs.setString('email', email);
  await prefs.setInt('Language', languageid);
  await prefs.setInt('userId', userId);
}

// Retrieving user data
Future<User> getUserData() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('auth_token');
  String? username = prefs.getString('username');
  String? email = prefs.getString('email');
  int? languageId = prefs.getInt('Language');
  int? userId = prefs.getInt('userId');

  return User(
    userId: userId ?? 0,
    username: username ?? '', // Providing a default value if null
    email: email ?? '',
    password: "", // This should be handled carefully
    languageId: languageId ?? 1,
  );
}

// Checking the token and user data at app startup
Future<bool> checkUserData() async {
  final User userData = await getUserData();
  return userData.email.isNotEmpty;
}
