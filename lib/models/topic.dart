import 'package:json_annotation/json_annotation.dart';
import 'package:ticket_app/models/question.dart';
import 'package:ticket_app/models/question_list.dart';
part 'topic.g.dart';

@JsonSerializable()
class Topic {
  final int id;
  final String name;
  final String description;
  final String image;
  final int language_id;
  final QuestionList? questions;

  Topic({
    required this.name,
    required this.description,
    required this.image,
    required this.language_id,
    required this.id,
    this.questions,
  });

  factory Topic.fromJson(Map<String, dynamic> json) => _$TopicFromJson(json);
  Map<String, dynamic> toJson() => _$TopicToJson(this);
}
