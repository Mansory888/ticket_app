// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
      user_id: json['user_id'] as int?,
      username: json['username'] as String,
      token: json['token'] as String?,
      email: json['email'] as String,
      language_id: json['language_id'] as int?,
      score: json['score'] as int?,
    );

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'user_id': instance.user_id,
      'username': instance.username,
      'email': instance.email,
      'language_id': instance.language_id,
      'score': instance.score,
      'token': instance.token,
    };
