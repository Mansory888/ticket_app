import 'package:json_annotation/json_annotation.dart';
part 'answer.g.dart';

@JsonSerializable()
class Answer {
  final String answer;
  final int questionId;
  @JsonKey(name: 'is_correct')
  final bool isCorrect;

  Answer({
    required this.answer,
    required this.questionId,
    required this.isCorrect,
  });

  factory Answer.fromJson(Map<String, dynamic> json) => _$AnswerFromJson(json);
  Map<String, dynamic> toJson() => _$AnswerToJson(this);
}
