import 'package:json_annotation/json_annotation.dart';

part 'parking.g.dart';

@JsonSerializable()

class Parking {
  @JsonKey(name: "Parking_lot_address")
  String? parkingAddress;
  @JsonKey(name: "Parking_lot_code")
  String? parkingCode;
  @JsonKey(name: "Parking_lot_id")
  int? parkingId;

  Parking({
    this.parkingAddress,
    this.parkingCode,
    this.parkingId,
  });
  factory Parking.fromJson(Map<String, dynamic> json) => _$ParkingFromJson(json);
  Map<String, dynamic> toJson() => _$ParkingToJson(this);
}