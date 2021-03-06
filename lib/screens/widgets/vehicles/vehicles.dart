import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_parking/models/list_vehicle_response.dart';
import 'package:my_parking/models/vehicle.dart';
import 'package:my_parking/network/api_client.dart';
import 'package:my_parking/screens/home.dart';
import 'package:my_parking/screens/widgets/vehicles/addEdit.dart';
import 'package:my_parking/utils/shared_preferences.dart';

class Vehicles extends StatefulWidget {
  const Vehicles({Key? key}) : super(key: key);
  @override
  VehiclesState createState() => VehiclesState();
}

class VehiclesState extends State<Vehicles> {
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

  Future<void> initiateDelete(Map data) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Delete Vehicle"),
            content:
                const Text("Are you sure you want to delete this vehicle?"),
            actions: <Widget>[
              TextButton(
                child: const Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text("Delete"),
                onPressed: () async {
                  await _apiClient.deleteVehicle(
                      token: token ?? "", data: data);
                  setState(() {
                    Navigator.of(context).pop();
                    getListVehicle();
                  });
                },
              ),
            ],
          );
        });
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
              "Available vehicles",
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
                            child: const Icon(Icons.edit),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddEditVehicle(
                                    list: vehicle,
                                    index: index,
                                    token: token ?? "",
                                  ),
                                ),
                              );
                              debugPrint("Vehicles not available");
                            },
                          ),
                          title: Text(vehicle_.vehicleCategoryName),
                          iconColor: Colors.red,
                          subtitle: Text(vehicle_.vehicleCategoryDesc),
                          trailing: GestureDetector(
                            child: const Icon(Icons.auto_delete),
                            onTap: () {
                              setState(() {
                                var map = <String, dynamic>{};
                                map['vehicle_id'] = vehicle_.vehicleCategoryId;
                                initiateDelete(map);
                              });
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
            tooltip: 'Add', // used by assistive technologies
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditVehicle(token: token ?? ""),
                ),
              );
              debugPrint('Clicked FloatingActionButton Button');
            },
          ),
        ));
  }
}
