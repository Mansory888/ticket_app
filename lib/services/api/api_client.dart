import 'dart:convert';
import 'package:http/http.dart' as http;

const BASE_URL = 'http://localhost:3000/drivingexam/v1/';

Future<http.Response> postRequest(
    String endpoint, Map<String, dynamic> data) async {
  final response = await http.post(
    Uri.parse('$BASE_URL$endpoint'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode(data),
  );
  return response;
}

Future<http.Response> getRequest(String endpoint) async {
  final response = await http.get(
    Uri.parse('$BASE_URL$endpoint'),
    headers: {'Content-Type': 'application/json'},
  );
  return response;
}
