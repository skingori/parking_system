// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_res_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResList _$UserResListFromJson(Map<String, dynamic> json) => UserResList(
      loginId: json['Login_id'] as int?,
      rank: json['Login_rank'] as String?,
      username: json['Login_username'] as String?,
    )..password = json['Login_password'] as String?;

Map<String, dynamic> _$UserResListToJson(UserResList instance) =>
    <String, dynamic>{
      'Login_id': instance.loginId,
      'Login_password': instance.password,
      'Login_rank': instance.rank,
      'Login_username': instance.username,
    };
