// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      user_id: json['user_id'] as int?,
      username: json['username'] as String,
      password: json['password'] as String,
      email: json['email'] as String,
      language_id: json['language_id'] as int?,
      score: json['score'] as int?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'user_id': instance.user_id,
      'username': instance.username,
      'password': instance.password,
      'email': instance.email,
      'language_id': instance.language_id,
      'score': instance.score,
    };
