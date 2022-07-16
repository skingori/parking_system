import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_parking/models/list_parking_response.dart';
import 'package:my_parking/models/parking.dart';
import 'package:my_parking/network/api_client.dart';
import 'package:my_parking/screens/widgets/vehicles.dart';
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
  String? token = "";
  bool isLoading = false;
  final ApiClient _apiClient = ApiClient();

  late ListParkingResponse listParkingResponse;

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
  GlobalKey<ScaffoldMessengerState>();


  Future getListUser() async {
    Response response;
    try {
      isLoading = true;

      response = await _apiClient.getParkingData(token!);

      isLoading = false;

      if (response.statusCode == 200 && response.data != null) {
        setState(() {
          listParkingResponse = ListParkingResponse.fromJson(response.data);
          parking = listParkingResponse.parking;
        });
      } else {
        parking = [];
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
      getListUser();
    });
  }

  @override
  void initState() {
    super.initState();
    initUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
        key: scaffoldMessengerKey,
      child: Scaffold(
      appBar: AppBar(
        title: Text(username ?? ""),
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
              onLongPress: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Vehicles(),
                  ),
                );
                debugPrint("get the student units");
              },
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => AddEditPageStudents(
                //       list: list,
                //       index: index,
                //     ),
                //   ),
                // );
                // debugPrint('Edit Clicked');
              },
            ),
            title: Text(park.parkingId.toString()),
            subtitle: Text(park.parkingAddress.toString()),
            trailing: GestureDetector(
              child: const Icon(Icons.add_location_alt_outlined),
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
                  backgroundColor: Colors.blue,
                ));
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
                    builder: (BuildContext context) => const LoginScreen()));
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
        backgroundColor: Colors.green,
        child: const Icon(Icons.logout_rounded),
      ),
    ));
  }
}
