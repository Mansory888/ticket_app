import 'package:json_annotation/json_annotation.dart';
import 'package:ticket_app/models/question.dart';
part 'question_list.g.dart';

@JsonSerializable()
class QuestionList {
  final List<Question> questions;
  final int totalQuestions;

  QuestionList({
    required this.questions,
    required this.totalQuestions,
  });

  factory QuestionList.fromJson(Map<String, dynamic> json) =>
      _$QuestionListFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionListToJson(this);
}
