// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mock_exam.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MockExam _$MockExamFromJson(Map<String, dynamic> json) => MockExam(
      id: json['id'] as int?,
      user_id: json['user_id'] as int?,
      percentage: json['percentage'] as int,
      questions: json['questions'] == null
          ? null
          : QuestionList.fromJson(json['questions'] as Map<String, dynamic>),
      completion_date: json['completion_date'] == null
          ? null
          : DateTime.parse(json['completion_date'] as String),
      points: json['points'] as int?,
      answered_questions: json['answered_questions'] == null
          ? null
          : QuestionList.fromJson(
              json['answered_questions'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MockExamToJson(MockExam instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'percentage': instance.percentage,
      'completion_date': instance.completion_date?.toIso8601String(),
      'questions': instance.questions,
      'points': instance.points,
      'answered_questions': instance.answered_questions,
    };
