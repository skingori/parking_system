// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkingInfo _$ParkingInfoFromJson(Map<String, dynamic> json) => ParkingInfo(
      id: json['id'] as String?,
      adress: json['adress'] as String?,
      code: json['code'] as String?,
      token: json['token'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ParkingInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..error = json['error'] as Map<String, dynamic>?;

Map<String, dynamic> _$ParkingInfoToJson(ParkingInfo instance) =>
    <String, dynamic>{
      'token': instance.token,
      'id': instance.id,
      'adress': instance.adress,
      'code': instance.code,
      'data': instance.data,
      'error': instance.error,
    };
