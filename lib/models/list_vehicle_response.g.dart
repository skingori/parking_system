// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_vehicle_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListVehicleResponse _$ListVehicleResponseFromJson(Map<String, dynamic> json) =>
    ListVehicleResponse(
      error: json['error'] as String?,
      message: json['message'] as String,
      status: json['status'] as bool?,
      vehicle: (json['data'] as List<dynamic>?)
          ?.map((e) => Vehicle.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListVehicleResponseToJson(
        ListVehicleResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'status': instance.status,
      'data': instance.vehicle,
    };
