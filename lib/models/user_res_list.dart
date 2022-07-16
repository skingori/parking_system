import 'package:json_annotation/json_annotation.dart';

part 'user_res_list.g.dart';

@JsonSerializable()
class UserResList {
  @JsonKey(name: "Login_id")
  int? loginId;
  @JsonKey(name: "Login_password")
  String? password;
  @JsonKey(name: "Login_rank")
  String? rank;
  @JsonKey(name: "Login_username")
  String? username;

  UserResList(
      {this.loginId, this.rank, this.username});
  factory UserResList.fromJson(Map<String, dynamic> json) =>
      _$UserResListFromJson(json);
  Map<String, dynamic> toJson() => _$UserResListToJson(this);
}