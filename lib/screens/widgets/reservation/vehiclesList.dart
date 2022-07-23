import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_parking/models/list_vehicle_response.dart';
import 'package:my_parking/models/vehicle.dart';
import 'package:my_parking/network/api_client.dart';
import 'package:my_parking/screens/home.dart';
import 'package:my_parking/screens/widgets/reservation/reservation.dart';
import 'package:my_parking/utils/shared_preferences.dart';

class VehiclesList extends StatefulWidget {
  final String parking;
  const VehiclesList(this.parking, {Key? key}) : super(key: key);
  @override
  VehiclesListState createState() => VehiclesListState();
}

class VehiclesListState extends State<VehiclesList> {
  bool isLoading = false;
  late String? username = "";
  late String? token = "";
  List<Vehicle>? vehicle;
  late ListVehicleResponse vehicleResponse;
  final ApiClient _apiClient = ApiClient();

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  Future getListVehicle() async {
    Response response;
    try {
      isLoading = true;
      response = await _apiClient.getVehicleData(token!);
      isLoading = false;
      if (response.statusCode == 200) {
        setState(() {
          vehicleResponse = ListVehicleResponse.fromJson(response.data);
          vehicle = vehicleResponse.vehicle;
        });
      } else {
        if (kDebugMode) {
          print("There is some problem status code not 200");
        }
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> initUserProfile() async {
    final username_ = await AppSharedPreferences.getUserName();
    final token_ = await AppSharedPreferences.getUserToken();
    setState(() {
      token = token_!;
      if (token == "" || token == null) {
        username = username_ ?? "";
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => const HomePage()));
      } else {
        getListVehicle();
      }
    });
  }

  @override
  void initState() {
    initUserProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for the major Material Components.
    return ScaffoldMessenger(
        key: scaffoldMessengerKey,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.green,
            title: const Text(
              "Select booking vehicle",
              style: TextStyle(color: Colors.white),
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_sharp),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => const HomePage()));
                },
              ),
            ],
          ),
          // body is the majority of the screen.
          body: isLoading
              ? const Center(child: CircularProgressIndicator())
              : vehicle != null
                  ? ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final vehicle_ = vehicle![index];
                        return ListTile(
                          leading: GestureDetector(
                            child: const Icon(Icons.directions_car),
                            onTap: () {
                              //   Navigator.of(context).push(MaterialPageRoute(
                              //       builder: (BuildContext context) => AddEdit(
                              //             vehicle: vehicle_,
                              //             isEdit: true,
                              //           )));
                              // },
                            },
                          ),
                          title: Text(vehicle_.vehicleCategoryName),
                          iconColor: Colors.green,
                          subtitle: Text(
                              "Charges from : KES ${vehicle_.vehicleCategoryDailyParkingFee} per hour"),
                          trailing: GestureDetector(
                            child: const Icon(Icons.check_box),
                            onTap: () {
                              // setState(() {
                              //   // var map = <String, dynamic>{};
                              //   // map['action'] = APIConstants.STUDENT_DELETE;
                              //   // map['id'] = list[index]['Student_ID'];
                              //   // var url = APIConstants.STUDENT_ROOT;
                              //   // http.post(url, body:map);
                              //   // self.Parking_slot_reservation_duration = duration on new widget
                              //   // self.Parking_slot_reservation_vehicle_category_id = category on vehicles list
                              //   // self.Parking_slot_reservation_Parking_lot_id = lot on home page => Done
                              //   // self.Parking_slot_reservation_driver_id = driver on login
                              //   // self.Parking_slot_reservation_booking_date = date on new widget
                              //   // self.Parking_slot_reservation_vehicle_reg_no = reg on new widget
                              // });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ReservationPage(
                                    parkingId: widget.parking,
                                    token: token ?? "",
                                    vehicleId:
                                        vehicle_.vehicleCategoryId.toString(),
                                  ),
                                ),
                              );
                              debugPrint(
                                  'Accepted ${vehicle_.vehicleCategoryName}');
                            },
                          ),
                        );
                      },
                      itemCount: vehicle?.length,
                    )
                  : const Center(
                      child: Text("No Data"),
                    ),
          floatingActionButton: FloatingActionButton(
            tooltip: 'Home',
            focusColor: Colors.green,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
              debugPrint('Clicked FloatingActionButton Button');
            }, // used by assistive technologies
            child: const Icon(Icons.home),
          ),
        ));
  }
}
