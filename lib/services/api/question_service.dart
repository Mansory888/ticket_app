import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ticket_app/models/question.dart';
import 'api_client.dart';

Future<List<Question>> getExam() async {
  final response = await getRequest('questions/exam');
  if (response.statusCode == 200) {
    List<dynamic> jsonList = json.decode(response.body) as List<dynamic>;
    return jsonList.map((json) => Question.fromJson(json)).toList();
  } else {
    throw response.body;
  }
}

Future<List<Question>> getQuestionsByTopicName(String topicName) async {
  final response = await getRequest('topics/$topicName');

  if (response.statusCode == 200) {
    List<dynamic> jsonList = json.decode(response.body) as List<dynamic>;
    return jsonList.map((json) => Question.fromJson(json)).toList();
  } else if (response.statusCode == 404) {
    throw Exception('Topic not found');
  } else {
    throw Exception('Failed to load questions: ${response.body}');
  }
}
