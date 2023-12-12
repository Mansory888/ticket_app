import 'package:json_annotation/json_annotation.dart';
import 'package:ticket_app/models/question.dart';
import 'package:ticket_app/models/question_list.dart';
import 'package:ticket_app/models/user.dart';
part 'mock_exam.g.dart';

@JsonSerializable()
class MockExam {
  final int? mockexam_id;
  final int? user_id;
  final double percentage;
  final DateTime? completion_date;
  final QuestionList? questions;
  final int? points;

  MockExam({
    this.mockexam_id,
    required this.user_id,
    required this.percentage,
    this.questions,
    this.completion_date,
    this.points,
  });

  factory MockExam.fromJson(Map<String, dynamic> json) =>
      _$MockExamFromJson(json);
  Map<String, dynamic> toJson() => _$MockExamToJson(this);
}
