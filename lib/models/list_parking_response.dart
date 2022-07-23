import 'package:json_annotation/json_annotation.dart';
import 'package:my_parking/models/parking.dart';

part 'list_parking_response.g.dart';

@JsonSerializable()
class ListParkingResponse {
  @JsonKey(name: "error")
  String? error;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "data")
  List<Parking>? parking;
  ListParkingResponse(
      {this.error, required this.message, this.status, required this.parking});
  factory ListParkingResponse.fromJson(Map<String, dynamic> json) =>
      _$ListParkingResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ListParkingResponseToJson(this);
}
