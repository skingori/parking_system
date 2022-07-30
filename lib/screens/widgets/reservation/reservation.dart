// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:my_parking/models/token_res.dart';
import 'package:my_parking/network/api_client.dart';
import 'package:intl/intl.dart';
import 'package:my_parking/screens/home.dart';
import 'package:my_parking/screens/login.dart';
import 'package:my_parking/utils/shared_preferences.dart';

class ReservationPage extends StatefulWidget {
  final String parkingId;
  final String vehicleId;
  const ReservationPage(
      {Key? key, required this.parkingId, required this.vehicleId})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => ReservationPageState();
}

class ReservationPageState extends State<ReservationPage> {
  final ApiClient _apiClient = ApiClient();
  final JWTdecode jwtDecode = JWTdecode();
  bool isLoading = false;
  String token = "";
  int driverId = 0;

  TextEditingController vehicleRegNumber = TextEditingController();
  TextEditingController parkingId = TextEditingController();
  TextEditingController vehicleCategoryID = TextEditingController();
  TextEditingController bookingDate = TextEditingController();
  TextEditingController bookingTime = TextEditingController();

  Future<void> makeReservation() async {
    if (vehicleRegNumber.text.isNotEmpty &&
        parkingId.text.isNotEmpty &&
        vehicleCategoryID.text.isNotEmpty &&
        bookingDate.text.isNotEmpty &&
        bookingTime.text.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Processing Data'),
        backgroundColor: Colors.green.shade300,
      ));

      try {
        final data = {
          'reservation_parking': parkingId.text,
          'reservation_vehicle': widget.vehicleId,
          'reservation__category': vehicleCategoryID.text,
          'reservation_driver': driverId,
          'reservation_date': '${bookingDate.text} ${bookingTime.text}',
        };

        final res = await _apiClient.makeReservation(token, data);
        if (res != null && res.statusCode == 200) {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text('Reservation Successful'),
            backgroundColor: Colors.green.shade300,
          ));
          //Dialog to confirm reservation
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Reservation Successful'),
              content: const Text('Do you want to print the receipt?'),
              actions: <Widget>[
                TextButton(
                  child: const Text('No'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  child: const Text('Yes'),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        } else {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text('Reservation Failed'),
            backgroundColor: Colors.red.shade300,
          ));
        }
      } on Exception catch (e) {
        isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red.shade300,
        ));
      }
    }
  }

  Future<void> getTokenFromSharedPreferences() async {
    bool isLoggedIn = await AppSharedPreferences.isUserLoggedIn();
    final jwtDetails = await jwtDecode.getJWTdecode();
    JWTdetails cases = JWTdetails.fromJson(jwtDetails);
    final token_ = cases.token;
    final status = cases.status;
    final id = cases.loginId;

    setState(() {
      if (status == true && isLoggedIn && token_ != null) {
        if (widget.parkingId != "" && widget.vehicleId != "") {
          vehicleCategoryID.text = widget.vehicleId;
          parkingId.text = widget.parkingId;
          token = token_;
          driverId = id ?? 0;
          isLoading = false;
        }
      } else {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen()));
      }
    });
  }

  @override
  void initState() {
    isLoading = true;
    getTokenFromSharedPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text('Reservation'),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: TextField(
                      controller: parkingId,
                      readOnly: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          // borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(),
                        ),
                        labelText: 'Parking code',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: TextField(
                      controller: vehicleCategoryID,
                      readOnly: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          // borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(),
                        ),
                        labelText: 'Category code',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: TextField(
                      controller: vehicleRegNumber,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          // borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(),
                        ),
                        labelText: 'Reistration number',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: TextField(
                      controller: bookingDate,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          // borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(),
                        ),
                        labelText: '15-12-1990',
                      ),
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate:
                              DateTime.now().add(const Duration(days: 365)),
                        );
                        if (picked != null) {
                          setState(() {
                            bookingDate.text =
                                DateFormat('dd-MM-yyyy').format(picked);
                          });
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: TextField(
                      controller: bookingTime,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          // borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(),
                        ),
                        labelText: '7:15:00',
                      ),
                      onTap: () async {
                        TimeOfDay? pickedTime = await showTimePicker(
                          initialTime: TimeOfDay.now(),
                          context: context,
                        );
                        if (pickedTime != null) {
                          //output 10:51 PM
                          DateTime parsedTime = DateFormat.jm()
                              .parse(pickedTime.format(context).toString());
                          String formattedTime =
                              DateFormat('HH:mm:ss').format(parsedTime);
                          setState(() {
                            bookingTime.text = formattedTime;
                          });
                        } else {
                          setState(() {
                            bookingTime.text = '';
                          });
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton(
                      onPressed: () {
                        validateAndReserve();
                        debugPrint('Clicked RaisedButton Button');
                      },
                      // color: Colors.redAccent,
                      // shape: ContinuousRectangleBorder(
                      //     borderRadius: BorderRadius.circular(80.0)),
                      child: const Text(
                        'Confirm Reservation',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  void validateAndReserve() {
    if (vehicleRegNumber.text.isEmpty) {
      // return a dialog box
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content:
                const Text('Please enter your vehicle registration number'),
            actions: <Widget>[
              FlatButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else if (bookingDate.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Please enter booking date'),
        backgroundColor: Colors.red.shade300,
      ));
    } else if (bookingTime.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Please enter booking time'),
        backgroundColor: Colors.red.shade300,
      ));
    } else {
      setState(() {
        isLoading = true;
        makeReservation();
      });
    }
  }
}
