import 'package:json_annotation/json_annotation.dart';

part 'token_res.g.dart';

@JsonSerializable()
class JWTdetails {
  @JsonKey(name: 'id')
  int? loginId;
  @JsonKey(name: 'username')
  String? username;
  @JsonKey(name: 'exp')
  int? exp;
  @JsonKey(name: 'status')
  bool? status;
  @JsonKey(name: 'token')
  String? token;
  JWTdetails({this.loginId, this.username, this.exp, this.status, this.token});
  factory JWTdetails.fromJson(Map<String, dynamic> json) =>
      _$JWTdetailsFromJson(json);
  Map<String, dynamic> toJson() => _$JWTdetailsToJson(this);
}
