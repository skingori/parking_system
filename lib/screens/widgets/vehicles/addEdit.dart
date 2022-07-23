// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:my_parking/network/api_client.dart';
import 'package:my_parking/screens/widgets/vehicles/vehicles.dart';

class AddEditVehicle extends StatefulWidget {
  final List? list;
  final int? index;
  final String token;
  const AddEditVehicle({Key? key, this.list, this.index, required this.token})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => AddEditVehicleState();
}

class AddEditVehicleState extends State<AddEditVehicle> {
  final ApiClient _apiClient = ApiClient();
  TextEditingController vehicleId = TextEditingController();
  TextEditingController vehicleCategory = TextEditingController();
  TextEditingController vehicleDescription = TextEditingController();
  TextEditingController vehicleFee = TextEditingController();
  bool editMode = false;

  void setEditMode(bool mode) {
    editMode = mode;
  }

  addUpdateData() async {
    var map = <String, dynamic>{};
    if (editMode) {
      map["vehicle_id"] =
          widget.list![widget.index!].vehicleCategoryId?.toString() ?? "";
      map["vehicle_category"] = vehicleCategory.text;
      map["vehicle_description"] = vehicleDescription.text;
      map["vehicle_fee"] = vehicleFee.text;
      final response = await _apiClient.updateVehicle(widget.token, map);
      if (response.statusCode == 200) {
        return true;
      }
    } else {
      map["vehicle_id"] = vehicleId.text;
      map["vehicle_category"] = vehicleCategory.text;
      map["vehicle_description"] = vehicleDescription.text;
      map["vehicle_fee"] = vehicleFee.text;
      final response = await _apiClient.addVehicle(widget.token, map);
      if (response.statusCode == 200) {
        return true;
      }
    }
  }

  @override
  void initState() {
    if (widget.index != null && widget.list != null) {
      setEditMode(true);
      final vehicle = widget.list![widget.index!];
      vehicleId.text = vehicle.vehicleCategoryId?.toString() ?? "";
      vehicleCategory.text = vehicle.vehicleCategoryName ?? "";
      vehicleDescription.text = vehicle.vehicleCategoryDesc ?? "";
      vehicleFee.text = vehicle.vehicleCategoryDailyParkingFee ?? "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('${editMode ? 'Update' : 'Add'} vehicle'),
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: vehicleId,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(),
                  ),
                  labelText: 'ID',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: vehicleCategory,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(),
                  ),
                  labelText: 'Category',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: vehicleFee,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(),
                  ),
                  labelText: 'Fee',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                controller: vehicleDescription,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(),
                  ),
                  labelText: 'Description',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    addUpdateData();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Vehicles(),
                      ),
                    );
                  });
                  debugPrint('Clicked RaisedButton Button');
                },
                // color: Colors.redAccent,
                // shape: ContinuousRectangleBorder(
                //     borderRadius: BorderRadius.circular(80.0)),
                child: Text(
                  editMode ? 'Update' : 'Save',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
