import 'package:json_annotation/json_annotation.dart';

part 'vehicle.g.dart';

@JsonSerializable()
class Vehicle {
  @JsonKey(name: "Vehicle_category_id")
  int vehicleCategoryId;
  @JsonKey(name: "Vehicle_category_name")
  String vehicleCategoryName;
  @JsonKey(name: "Vehicle_category_desc")
  String vehicleCategoryDesc;
  @JsonKey(name: "Vehicle_category_daily_parking_fee")
  String vehicleCategoryDailyParkingFee;

  Vehicle({
    required this.vehicleCategoryId,
    required this.vehicleCategoryName,
    required this.vehicleCategoryDesc,
    required this.vehicleCategoryDailyParkingFee,
  });
  factory Vehicle.fromJson(Map<String, dynamic> json) =>
      _$VehicleFromJson(json);
  Map<String, dynamic> toJson() => _$VehicleToJson(this);
}
