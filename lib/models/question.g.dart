// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
      question: json['question'] as String,
      topicId: json['topic_id'] as int,
      image: json['image'] as String,
      explanation: json['explanation'] as String,
      answers: (json['answers'] as List<dynamic>)
          .map((e) => Answer.fromJson(e as Map<String, dynamic>))
          .toList(),
      topic: Topic.fromJson(json['topic'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'question': instance.question,
      'topic_id': instance.topicId,
      'image': instance.image,
      'explanation': instance.explanation,
      'answers': instance.answers,
      'topic': instance.topic,
    };
