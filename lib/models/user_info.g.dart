// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      email: json['email'] as String?,
      password: json['password'] as String?,
      id: json['id'] as String?,
      rank: json['rank'] as String?,
    )
      ..error = json['error'] as String?
      ..message = json['message'] as String?
      ..data = json['data'] as Map<String, dynamic>?;

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'id': instance.id,
      'rank': instance.rank,
      'error': instance.error,
      'message': instance.message,
      'data': instance.data,
    };
