// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Answer _$AnswerFromJson(Map<String, dynamic> json) => Answer(
      answer: json['answer'] as String,
      questionId: json['questionId'] as int,
      isCorrect: json['is_correct'] as bool,
    );

Map<String, dynamic> _$AnswerToJson(Answer instance) => <String, dynamic>{
      'answer': instance.answer,
      'questionId': instance.questionId,
      'is_correct': instance.isCorrect,
    };