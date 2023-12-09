import 'package:json_annotation/json_annotation.dart';
import 'package:ticket_app/models/question.dart';
import 'package:ticket_app/models/question_list.dart';
import 'package:ticket_app/models/user.dart';
part 'mock_exam.g.dart';

@JsonSerializable()
class MockExam {
  final int? id;
  final int? user_id;
  final int percentage;
  final DateTime? completion_date;
  final QuestionList? questions;
  final int? points;
  QuestionList? answered_questions;

  MockExam({
    this.id,
    required this.user_id,
    required this.percentage,
    this.questions,
    this.completion_date,
    this.points,
    this.answered_questions,
  });

  factory MockExam.fromJson(Map<String, dynamic> json) =>
      _$MockExamFromJson(json);
  Map<String, dynamic> toJson() => _$MockExamToJson(this);
}
