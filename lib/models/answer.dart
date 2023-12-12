import 'package:json_annotation/json_annotation.dart';
part 'answer.g.dart';

@JsonSerializable()
class Answer {
  final int answer_id;
  final String answer;
  final int questionId;
  @JsonKey(name: 'is_correct')
  final bool is_correct;
  bool? selected;

  Answer({
    required this.answer_id,
    required this.answer,
    required this.questionId,
    required this.is_correct,
    this.selected,
  });

  factory Answer.noAnswer() {
    return Answer(
        answer_id: 0,
        answer: 'No correct answer',
        questionId: 0,
        is_correct: false);
  }

  factory Answer.fromJson(Map<String, dynamic> json) => _$AnswerFromJson(json);
  Map<String, dynamic> toJson() => _$AnswerToJson(this);
}
