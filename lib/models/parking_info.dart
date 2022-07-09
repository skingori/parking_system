import 'package:json_annotation/json_annotation.dart';

part 'parking_info.g.dart';

@JsonSerializable()
class ParkingInfo {
  String? token;
  String? id;
  String? adress;
  String? code;
  List<ParkingInfo>? data;
  Map<String, dynamic>? error;
  ParkingInfo({this.id, this.adress, this.code, this.token, this.data});
  factory ParkingInfo.fromJson(Map<String, dynamic> json) =>
      _$ParkingInfoFromJson(json);
  Map<String, dynamic> toJson() => _$ParkingInfoToJson(this);
}
