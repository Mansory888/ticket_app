import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  final int? user_id;
  final String username;
  final String password;
  final String email;
  final int? language_id;
  final int? score;

  User(
      {this.user_id,
      required this.username,
      required this.password,
      required this.email,
      this.language_id,
      this.score});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
