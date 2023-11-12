import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  final int? userId;
  final String username;
  final String password;
  final String email;
  final int? languageId;

  User(
      {this.userId,
      required this.username,
      required this.password,
      required this.email,
      this.languageId});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
