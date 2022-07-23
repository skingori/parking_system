// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:my_parking/network/api_client.dart';
import 'package:intl/intl.dart';
import 'package:my_parking/screens/home.dart';

class ReservationPage extends StatefulWidget {
  final String parkingId;
  final String vehicleId;
  final String token;
  const ReservationPage(
      {Key? key,
      required this.parkingId,
      required this.vehicleId,
      required this.token})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => ReservationPageState();
}

class ReservationPageState extends State<ReservationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ApiClient _apiClient = ApiClient();
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
          'reservation_driver': '45345534',
          'reservation_date': '${bookingDate.text} ${bookingTime.text}',
        };

        final res = await _apiClient.makeReservation(widget.token, data);
        if (res != null && res.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Reservation made successfully'),
            backgroundColor: Colors.green.shade300,
          ));
          // Navigate to home
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('${res?.error}'),
            backgroundColor: Colors.red.shade300,
          ));
        }
      } on Exception catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${e.toString()}'),
          backgroundColor: Colors.red.shade300,
        ));
      }
    }
  }

  @override
  void initState() {
    if (widget.parkingId != "" &&
        widget.vehicleId != "" &&
        widget.token != "") {
      vehicleCategoryID.text = widget.vehicleId;
      parkingId.text = widget.parkingId;
    }
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
        body: ListView(
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
                    lastDate: DateTime.now().add(const Duration(days: 365)),
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
                  setState(() {
                    makeReservation();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
                  });
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
}
