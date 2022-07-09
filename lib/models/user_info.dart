import 'package:json_annotation/json_annotation.dart';

part 'user_info.g.dart';

@JsonSerializable()
class UserInfo {
  String? email;
  String? password;
  String? id;
  String? rank;
  String? error;
  String? message;
  Map? data;

  UserInfo({this.email, required this.password, required this.id, this.rank});
  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}
