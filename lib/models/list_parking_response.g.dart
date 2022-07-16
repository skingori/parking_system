// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_parking_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListParkingResponse _$ListParkingResponseFromJson(Map<String, dynamic> json) =>
    ListParkingResponse(
      error: json['error'] as String?,
      message: json['message'] as String,
      status: json['status'] as bool?,
      parking: (json['data'] as List<dynamic>)
          .map((e) => Parking.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListParkingResponseToJson(
        ListParkingResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'status': instance.status,
      'data': instance.parking,
    };
