// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionStatus _$QuestionStatusFromJson(Map<String, dynamic> json) =>
    QuestionStatus(
      questionId: json['questionId'] as int,
      userId: json['userId'] as int,
      status: json['status'] as String,
    );

Map<String, dynamic> _$QuestionStatusToJson(QuestionStatus instance) =>
    <String, dynamic>{
      'questionId': instance.questionId,
      'userId': instance.userId,
      'status': instance.status,
    };
