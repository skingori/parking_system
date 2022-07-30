// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JWTdetails _$JWTdetailsFromJson(Map<String, dynamic> json) => JWTdetails(
      loginId: json['id'] as int?,
      username: json['username'] as String?,
      exp: json['exp'] as int?,
      status: json['status'] as bool?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$JWTdetailsToJson(JWTdetails instance) =>
    <String, dynamic>{
      'id': instance.loginId,
      'username': instance.username,
      'exp': instance.exp,
      'status': instance.status,
      'token': instance.token,
    };
