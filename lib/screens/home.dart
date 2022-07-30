import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_parking/models/list_parking_response.dart';
import 'package:my_parking/models/parking.dart';
import 'package:my_parking/models/token_res.dart';
import 'package:my_parking/network/api_client.dart';
import 'package:my_parking/screens/widgets/reservation/vehiclesList.dart';
import 'package:my_parking/screens/widgets/vehicles/vehicles.dart';
import 'package:my_parking/utils/shared_preferences.dart';

import 'login.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String? username = "";
  List<Parking>? parking;
  bool isLoading = false;
  final ApiClient _apiClient = ApiClient();
  late ListParkingResponse listParkingResponse;
  final JWTdecode jwtDecode = JWTdecode();

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  Future<void> initUserProfile() async {
    // final username_ = await AppSharedPreferences.getUserName();
    bool isLoggedIn = await AppSharedPreferences.isUserLoggedIn();
    // final token_ = await AppSharedPreferences.getUserToken();
    final jwtDetails = await jwtDecode.getJWTdecode();
    JWTdetails cases = JWTdetails.fromJson(jwtDetails);
    final token_ = cases.token;
    final status = cases.status;
    final username_ = cases.username;

    setState(() {
      // if user is logged off then navigate to login page
      if (status == true && isLoggedIn && token_ != null) {
        username = username_;
        isLoading = true;
        getListUser(token_);
      } else {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen()));
      }
    });
  }

  @override
  void initState() {
    initUserProfile();
    super.initState();
  }

  Future getListUser(String token) async {
    Response response;
    try {
      response = await _apiClient.getParkingData(token);
      isLoading = false;
      if (response.statusCode == 200 && response.data != null) {
        setState(() {
          listParkingResponse = ListParkingResponse.fromJson(response.data);
          parking = listParkingResponse.parking;
        });
      } else {
        if (kDebugMode) {
          print("There is some problem status code not 200");
        }
      }
    } on Exception catch (e) {
      isLoading = false;
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
        key: scaffoldMessengerKey,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Get your parking spot",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            backgroundColor: Colors.green,
          ),
          body: isLoading
              ? const Center(child: CircularProgressIndicator())
              : parking != null
                  ? ListView.builder(
                      itemBuilder: (context, index) {
                        final park = parking![index];
                        return ListTile(
                          leading: GestureDetector(
                            child: const Icon(Icons.directions_car),
                            onLongPress: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Vehicles(),
                                ),
                              );
                              debugPrint("long press");
                            },
                          ),
                          title: Text(park.parkingId.toString()),
                          subtitle: Text(park.parkingAddress.toString()),
                          iconColor: Colors.blue,
                          trailing: GestureDetector(
                            child: const Icon(Icons.add_location_alt_outlined),
                            onTap: () {
                              setState(() {
                                final parking = park.parkingId.toString();
                                // var map = <String, dynamic>{};
                                // "reservation_date":"23-08-2022 00:45:18.000227",
                                // "reservation_vehicle": "KDA-45234",
                                // "reservation_parking":"455656",
                                // "reservation_driver":"1234567",
                                // "reservation__category": "43543534"
                                // self.Parking_slot_reservation_duration = duration on new widget
                                // self.Parking_slot_reservation_vehicle_category_id = category on vehicles list
                                // self.Parking_slot_reservation_Parking_lot_id = lot on home page
                                // self.Parking_slot_reservation_driver_id = driver on login
                                // self.Parking_slot_reservation_booking_date = date on new widget
                                // self.Parking_slot_reservation_vehicle_reg_no = reg on new widget
                                // map['action'] = APIConstants.STUDENT_DELETE;
                                // map['id'] = list[index]['Student_ID'];
                                // var url = APIConstants.STUDENT_ROOT;
                                // http.post(url, body:map);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VehiclesList(parking),
                                  ),
                                );
                              });
                              debugPrint('Booked Clicked');
                            },
                          ),
                        );
                      },
                      itemCount: parking?.length,
                    )
                  : const Center(
                      child: Text("No User Object"),
                    ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Colors.green,
                  ),
                  child: Text(
                    username ?? "",
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Profile'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.car_repair),
                  title: const Text('Parking'),
                  onTap: () {
                    setState(() {
                      initUserProfile();
                    });
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => const HomePage()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.book),
                  title: const Text('Reservations'),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => const Vehicles()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.workspace_premium),
                  title: const Text('Vehicle'),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => const Vehicles()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.handshake),
                  title: const Text('Payments'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                  onTap: () {
                    AppSharedPreferences.clear();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const LoginScreen()));
                  },
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              AppSharedPreferences.clear();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const LoginScreen()));
            },
            backgroundColor: Colors.red,
            child: const Icon(Icons.logout_rounded),
          ),
        ));
  }
}
