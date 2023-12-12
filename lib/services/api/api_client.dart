import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ticket_app/models/user.dart';
import 'package:ticket_app/models/user_response.dart';
import '../../services/api/user_service.dart';

const BASE_URL = 'http://144.91.86.43:3000/drivingexam/v1/';

Future<http.Response> postRequest(
    String endpoint, Map<String, dynamic> data) async {
  UserResponse userData = await getUserData();
  final response = await http.post(
    Uri.parse('$BASE_URL$endpoint'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${userData.token}', // Add token to the header
    },
    body: json.encode(data),
  );
  return response;
}

Future<http.Response> getRequest(String endpoint) async {
  UserResponse userData = await getUserData();
  final response = await http.get(
    Uri.parse('$BASE_URL$endpoint'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${userData.token}', // Add token to the header
    },
  );
  return response;
}
