import 'package:json_annotation/json_annotation.dart';
import 'answer.dart';
import 'topic.dart';
part 'question.g.dart';

@JsonSerializable()
class Question {
  final String question;
  @JsonKey(name: 'topic_id')
  final int topicId;
  final String image;
  final String explanation;
  final List<Answer> answers;
  final Topic topic;

  Question({
    required this.question,
    required this.topicId,
    required this.image,
    required this.explanation,
    required this.answers,
    required this.topic,
  });

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}
