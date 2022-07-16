// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      id: json['id'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
    )
      ..error = json['error'] as String?
      ..message = json['message'] as String?
      ..status = json['status'] as bool?
      ..data = json['data'] == null
          ? null
          : UserResList.fromJson(json['data'] as Map<String, dynamic>);

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'password': instance.password,
      'error': instance.error,
      'message': instance.message,
      'status': instance.status,
      'data': instance.data,
    };
