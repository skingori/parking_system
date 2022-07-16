import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_parking/models/list_vehicle_response.dart';
import 'package:my_parking/models/vehicle.dart';
import 'package:my_parking/network/api_client.dart';
import 'package:my_parking/screens/home.dart';
import 'package:my_parking/screens/login.dart';
import 'package:my_parking/utils/shared_preferences.dart';

class Vehicles extends StatefulWidget {
  const Vehicles({Key? key}) : super(key: key);
  @override
  VehiclesState createState() => VehiclesState();
}

class VehiclesState extends State<Vehicles> {
  bool isLoading = false;
  late String username = "";
  late String? token = "";
  List<Vehicle>? vehicle;
  late ListVehicleResponse vehicleResponse;
  final ApiClient _apiClient = ApiClient();


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
      isLoading = false;
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> initUserProfile() async {
    final username_ = await AppSharedPreferences.getUserName();
    final token_ = await AppSharedPreferences.getUserToken();
    setState(() {
      username = username_!;
      token = token_!;
      if (token == null) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => const HomePage()));
      }else{
        getListVehicle();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    initUserProfile();
  }
  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for the major Material Components.
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        title: Text(username),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.home),
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
        itemBuilder: (context, index) {
          final vehicle_ = vehicle![index];
          return ListTile(
            leading: GestureDetector(
              child: const Icon(Icons.edit),
              onLongPress: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Vehicles(),
                  ),
                );
                debugPrint("Vehicles not available");
              },
            ),
            title: Text(vehicle_.vehicleCategoryName),
            subtitle: Text(vehicle_.vehicleCategoryDesc),
            trailing: GestureDetector(
              child: const Icon(Icons.auto_delete),
              onTap: () {
                setState(() {
                  var map = <String, dynamic>{};
                  // map['action'] = APIConstants.STUDENT_DELETE;
                  // map['id'] = list[index]['Student_ID'];
                  // var url = APIConstants.STUDENT_ROOT;
                  // http.post(url, body:map);
                });
                Scaffold.of(context).showSnackBar(const SnackBar(
                  content: Text("Booked"),
                  backgroundColor: Colors.red,
                ));
                debugPrint('Deleted');
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
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => AddEditPageStudents(),
          //   ),
          // );
          // debugPrint('Clicked FloatingActionButton Button');
        },
      ),
    );
  }
}