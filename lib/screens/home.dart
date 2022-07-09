import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_parking/models/parking_info.dart';
import 'package:my_parking/network/api_client.dart';

class HomePage extends StatefulWidget {
  final String username;
  final String token;

  const HomePage({Key? key, required this.username, required this.token})
      : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiClient _apiClient = ApiClient();

  Future<dynamic> getParkingInfo() async {
    final res = await _apiClient.getParkingData(widget.token);
    if (res != null && res.error == null) {
      final List<ParkingInfo> parkingInfo = res.data!
          .map<ParkingInfo>((json) => ParkingInfo.fromJson(json))
          .toList();
      return parkingInfo;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.username),
        backgroundColor: Colors.green,
      ),
      body: Center(
          child: FutureBuilder<dynamic>(
              future: getParkingInfo(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final ParkingInfo parkingInfo = snapshot.data![index];
                      return ListTile(
                        title: Text(parkingInfo.id.toString()),
                        subtitle: Text(parkingInfo.code.toString()),
                        trailing: Text(parkingInfo.adress.toString()),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                } else {
                  return CircularProgressIndicator();
                }
              })),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.green,
              ),
              child: Text(
                'Hello ${widget.username}',
                style: TextStyle(fontSize: 20),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.book),
              title: const Text('Reservations'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.workspace_premium),
              title: const Text('Vehicle'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.handshake),
              title: const Text('Payments'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: const Text('LogOut'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
