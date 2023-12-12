import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ticket_app/models/user_response.dart';

import '/models/user.dart';
import 'api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> registerUser(Map<String, dynamic> userData) async {
  final response = await postRequest('users/register', userData);

  if (response.statusCode == 201) {
    return response.body;
  } else {
    List<String> errorMessages = extractErrorMessages(response.body);
    throw errorMessages.join(', ');
  }
}

Future<Map<String, dynamic>> loginUser(Map<String, dynamic> credentials) async {
  final response = await postRequest('users/login', credentials);

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    List<String> errorMessages = extractErrorMessages(response.body);
    throw errorMessages.join(', ');
  }
}

Future<List<UserResponse>> getAllUsers() async {
  final response = await getRequest('users');

  if (response.statusCode == 200) {
    List<dynamic> jsonList = json.decode(response.body) as List<dynamic>;
    return jsonList.map((json) => UserResponse.fromJson(json)).toList();
  } else {
    throw response.body;
  }
}

List<String> extractErrorMessages(String responseBody) {
  try {
    final Map<String, dynamic> responseMap = json.decode(responseBody);
    if (responseMap.containsKey('errors') && responseMap['errors'] is List) {
      return (responseMap['errors'] as List)
          .map((error) => error['msg'].toString())
          .toList();
    } else {
      return ['Unknown error'];
    }
  } catch (e) {
    return ['Error parsing response: $e'];
  }
}

// Saving user data
Future<void> persistUserData(String token, String username, String email,
    int languageid, int userId) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token);
  await prefs.setString('username', username);
  await prefs.setString('email', email);
  await prefs.setInt('language_id', languageid);
  await prefs.setInt('user_id', userId);
}

// Retrieving user data
Future<UserResponse> getUserData() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  String? username = prefs.getString('username');
  String? email = prefs.getString('email');
  int? languageId = prefs.getInt('language_id');
  int? userId = prefs.getInt('user_id');

  return UserResponse(
    user_id: userId ?? 0,
    username: username ?? '',
    email: email ?? '',
    token: token ?? '',
    language_id: languageId ?? 1,
  );
}

// Checking the token and user data at app startup
Future<bool> checkUserData() async {
  final UserResponse userData = await getUserData();
  return userData.email.isNotEmpty;
}
