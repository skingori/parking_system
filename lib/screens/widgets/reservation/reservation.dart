// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:my_parking/network/api_client.dart';
import 'package:intl/intl.dart';

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

  Future<void> registerUsers() async {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Processing Data'),
        backgroundColor: Colors.green.shade300,
      ));
    }
  }

  @override
  void initState() {
    // self.Parking_slot_reservation_duration = duration on new widget
    //   // self.Parking_slot_reservation_vehicle_category_id = category on vehicles list
    //   // self.Parking_slot_reservation_Parking_lot_id = lot on home page => Done
    //   // self.Parking_slot_reservation_driver_id = driver on login
    //   // self.Parking_slot_reservation_booking_date = date on new widget
    //   // self.Parking_slot_reservation_vehicle_reg_no = reg on new widget
    // if (widget.index != null && widget.list != null) {
    //   final vehicle = widget.list![widget.index!];
    //   vehicleId.text = vehicle.vehicleCategoryId?.toString() ?? "";
    //   vehicleCategory.text = vehicle.vehicleCategoryName ?? "";
    //   vehicleDescription.text = vehicle.vehicleCategoryDesc ?? "";
    //   vehicleFee.text = vehicle.vehicleCategoryDailyParkingFee ?? "";
    // }
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
                  labelText: 'Reistration Number',
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
                  labelText: 'Select Date',
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
                          DateFormat('yyyy-MM-dd').format(picked);
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
                  labelText: 'Select Time',
                ),
                onTap: () async {
                  final TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (picked != null) {
                    setState(() {
                      bookingTime.text = picked.format(context);
                    });
                  } else {
                    setState(() {
                      bookingTime.text = "";
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
                    // addUpdateData();
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const Vehicles(),
                    //   ),
                    // );
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
