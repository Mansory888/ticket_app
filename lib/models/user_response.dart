import 'package:json_annotation/json_annotation.dart';
part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  final int? user_id;
  final String username;
  final String email;
  final int? language_id;
  final int? score;
  final String? token;

  UserResponse(
      {this.user_id,
      required this.username,
      this.token,
      required this.email,
      this.language_id,
      this.score});

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}
