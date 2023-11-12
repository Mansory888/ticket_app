// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      userId: json['userId'] as int?,
      username: json['username'] as String,
      password: json['password'] as String,
      email: json['email'] as String,
      languageId: json['languageId'] as int?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userId': instance.userId,
      'username': instance.username,
      'password': instance.password,
      'email': instance.email,
      'languageId': instance.languageId,
    };
