// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vehicle _$VehicleFromJson(Map<String, dynamic> json) => Vehicle(
      vehicleCategoryId: json['Vehicle_category_id'] as int,
      vehicleCategoryName: json['Vehicle_category_name'] as String,
      vehicleCategoryDesc: json['Vehicle_category_desc'] as String,
      vehicleCategoryDailyParkingFee:
          json['Vehicle_category_daily_parking_fee'] as String,
    );

Map<String, dynamic> _$VehicleToJson(Vehicle instance) => <String, dynamic>{
      'Vehicle_category_id': instance.vehicleCategoryId,
      'Vehicle_category_name': instance.vehicleCategoryName,
      'Vehicle_category_desc': instance.vehicleCategoryDesc,
      'Vehicle_category_daily_parking_fee':
          instance.vehicleCategoryDailyParkingFee,
    };
