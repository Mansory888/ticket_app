// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Topic _$TopicFromJson(Map<String, dynamic> json) => Topic(
      name: json['name'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      language_id: json['language_id'] as int,
      id: json['id'] as int,
      questions: json['questions'] == null
          ? null
          : QuestionList.fromJson(json['questions'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TopicToJson(Topic instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
      'language_id': instance.language_id,
      'questions': instance.questions,
    };
