import 'package:json_annotation/json_annotation.dart';
import 'package:my_parking/models/vehicle.dart';

part 'list_vehicle_response.g.dart';

@JsonSerializable()
class ListVehicleResponse {
  @JsonKey(name: "error")
  String? error;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "data")
  List<Vehicle>? vehicle;
  ListVehicleResponse(
      {this.error, required this.message, this.status, required this.vehicle});
  factory ListVehicleResponse.fromJson(Map<String, dynamic> json) =>
      _$ListVehicleResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ListVehicleResponseToJson(this);
}
