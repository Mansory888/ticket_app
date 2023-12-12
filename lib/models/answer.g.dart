// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Answer _$AnswerFromJson(Map<String, dynamic> json) => Answer(
      answer_id: json['answer_id'] as int,
      answer: json['answer'] as String,
      questionId: json['questionId'] as int,
      is_correct: json['is_correct'] as bool,
      selected: json['selected'] as bool?,
    );

Map<String, dynamic> _$AnswerToJson(Answer instance) => <String, dynamic>{
      'answer_id': instance.answer_id,
      'answer': instance.answer,
      'questionId': instance.questionId,
      'is_correct': instance.is_correct,
      'selected': instance.selected,
    };
