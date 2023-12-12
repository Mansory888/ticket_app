// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mock_exam.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MockExam _$MockExamFromJson(Map<String, dynamic> json) => MockExam(
      mockexam_id: json['mockexam_id'] as int?,
      user_id: json['user_id'] as int?,
      percentage: (json['percentage'] as num).toDouble(),
      questions: json['questions'] == null
          ? null
          : QuestionList.fromJson(json['questions'] as Map<String, dynamic>),
      completion_date: json['completion_date'] == null
          ? null
          : DateTime.parse(json['completion_date'] as String),
      points: json['points'] as int?,
    );

Map<String, dynamic> _$MockExamToJson(MockExam instance) => <String, dynamic>{
      'mockexam_id': instance.mockexam_id,
      'user_id': instance.user_id,
      'percentage': instance.percentage,
      'completion_date': instance.completion_date?.toIso8601String(),
      'questions': instance.questions,
      'points': instance.points,
    };
