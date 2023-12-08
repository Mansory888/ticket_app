// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionList _$QuestionListFromJson(Map<String, dynamic> json) => QuestionList(
      questions: (json['questions'] as List<dynamic>)
          .map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalQuestions: json['totalQuestions'] as int,
    );

Map<String, dynamic> _$QuestionListToJson(QuestionList instance) =>
    <String, dynamic>{
      'questions': instance.questions,
      'totalQuestions': instance.totalQuestions,
    };
