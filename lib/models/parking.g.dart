// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Parking _$ParkingFromJson(Map<String, dynamic> json) => Parking(
      parkingAddress: json['Parking_lot_address'] as String?,
      parkingCode: json['Parking_lot_code'] as String?,
      parkingId: json['Parking_lot_id'] as int?,
    );

Map<String, dynamic> _$ParkingToJson(Parking instance) => <String, dynamic>{
      'Parking_lot_address': instance.parkingAddress,
      'Parking_lot_code': instance.parkingCode,
      'Parking_lot_id': instance.parkingId,
    };
