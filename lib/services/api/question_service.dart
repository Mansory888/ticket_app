import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ticket_app/models/mock_exam.dart';
import 'package:ticket_app/models/question.dart';
import 'package:ticket_app/models/question_list.dart';
import 'package:ticket_app/models/question_report.dart';
import 'package:ticket_app/models/topic.dart';
import 'api_client.dart';

Future<MockExam> getExam(int languageId) async {
  final response = await getRequest('mockexams/create/$languageId');

  if (response.statusCode == 200) {
    Map<String, dynamic> jsonData = json.decode(response.body);
    return MockExam.fromJson(jsonData);
  } else {
    throw response.body;
  }
}

Future<List<MockExam>> getAllMockExams() async {
  final response = await getRequest('mockexams/users');

  if (response.statusCode == 200) {
    List<dynamic> jsonList = json.decode(response.body) as List<dynamic>;
    return jsonList.map((json) => MockExam.fromJson(json)).toList();
  } else {
    throw response.body;
  }
}

Future<QuestionList> getQuestionsByTopicId(int topicId) async {
  final response = await getRequest('topics/questions/$topicId');
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonData = json.decode(response.body);
    return QuestionList.fromJson(jsonData);
  } else if (response.statusCode == 404) {
    throw Exception('Topic not found');
  } else {
    throw Exception('Failed to load questions: ${response.body}');
  }
}

Future<List<Topic>> getAllTopics(int languageId) async {
  final response = await getRequest('topics/$languageId');

  if (response.statusCode == 200) {
    List<dynamic> jsonList = json.decode(response.body) as List<dynamic>;
    return jsonList.map((json) => Topic.fromJson(json)).toList();
  } else {
    throw response.body;
  }
}

Future<Question> postQuestion(Question question) async {
  final response = await postRequest('questions', question.toJson());

  if (response.statusCode == 200) {
    Map<String, dynamic> jsonData = json.decode(response.body);
    return Question.fromJson(jsonData);
  } else {
    throw response.body;
  }
}

Future<String> postQuestionReport(QuestionReport questionReport) async {
  final response =
      await postRequest('questions/report', questionReport.toJson());

  if (response.statusCode == 201) {
    return response.body;
  } else {
    throw response.body;
  }
}

Future<MockExam> postMockExam(MockExam exam) async {
  final response = await postRequest('mockexams', exam.toJson());

  if (response.statusCode == 200) {
    Map<String, dynamic> jsonData = json.decode(response.body);
    return MockExam.fromJson(jsonData);
  } else {
    throw response.body;
  }
}
