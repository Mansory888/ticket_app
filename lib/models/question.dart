import 'package:json_annotation/json_annotation.dart';
import 'package:ticket_app/models/question_status.dart';
import 'answer.dart';
import 'topic.dart';
part 'question.g.dart';

@JsonSerializable()
class Question {
  final int question_id;
  final String question;
  final int topic_id;
  final String image;
  final String explanation;
  final List<Answer> answers;
  final String status;

  Question({
    required this.question_id,
    required this.question,
    required this.topic_id,
    required this.image,
    required this.explanation,
    required this.answers,
    required this.status,
  });

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}
