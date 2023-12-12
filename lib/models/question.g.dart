// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
      question_id: json['question_id'] as int,
      question: json['question'] as String,
      topic_id: json['topic_id'] as int,
      image: json['image'] as String,
      explanation: json['explanation'] as String,
      answers: (json['answers'] as List<dynamic>)
          .map((e) => Answer.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String,
    );

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'question_id': instance.question_id,
      'question': instance.question,
      'topic_id': instance.topic_id,
      'image': instance.image,
      'explanation': instance.explanation,
      'answers': instance.answers,
      'status': instance.status,
    };
