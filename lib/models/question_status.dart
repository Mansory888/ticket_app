import 'package:json_annotation/json_annotation.dart';
part 'question_status.g.dart';

@JsonSerializable()
class QuestionStatus {
  final int questionId;
  final int userId;
  final String status;

  QuestionStatus(
      {required this.questionId, required this.userId, required this.status});

  factory QuestionStatus.fromJson(Map<String, dynamic> json) =>
      _$QuestionStatusFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionStatusToJson(this);
}
