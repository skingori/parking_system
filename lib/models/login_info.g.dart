// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginInfo _$LoginInfoFromJson(Map<String, dynamic> json) => LoginInfo(
      email: json['email'] as String?,
      password: json['password'] as String?,
    )
      ..message = json['message'] as String?
      ..status = json['status'] as bool?
      ..error = json['error'] as String?
      ..data = json['data'] as Map<String, dynamic>?;

Map<String, dynamic> _$LoginInfoToJson(LoginInfo instance) => <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'message': instance.message,
      'status': instance.status,
      'error': instance.error,
      'data': instance.data,
    };
