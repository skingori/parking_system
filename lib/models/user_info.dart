import 'package:json_annotation/json_annotation.dart';
import 'package:my_parking/models/user_res_list.dart';

part 'user_info.g.dart';

@JsonSerializable()
class UserInfo {
  String? id;
  String? email;
  String? password;
  String? error;
  String? message;
  bool? status;
  @JsonKey(name: "data")
  UserResList? data;
  UserInfo({this.id, this.email, this.password});
  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}
