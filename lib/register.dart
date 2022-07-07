import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'api.dart';
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _userid = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _level = TextEditingController();

  String baseUrl = Api.baseurl + Api.regis;

  String msg = "";

  static const items = <String>["user"];

  final List<DropdownMenuItem<String>> _myitems = items
      .map((e) => DropdownMenuItem(
            value: e,
            child: Text(e),
          ))
      .toList();

  String valueItem = "user";

  insertApi() async {
    var url_ = Uri.parse(baseUrl);
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    var body = {
      'user_id': _userid.text,
      'username': _username.text,
      'password': _password.text,
      'level': 'user',
    };
    var res =
        await http.post(url_, headers: requestHeaders, body: json.encode(body));
    var dataJson = json.decode(res.body);
    if (res.statusCode == 201) {
      _userid.clear();
      _username.clear();
      _password.clear();
      _level.clear();
      print(res.body);
      setState(() {
        msg = "Registration Successful!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        backgroundColor: Colors.pink,
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: ListView(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [Colors.amber, Colors.pink]),
                    borderRadius: BorderRadius.circular(20.0)),
                child: TextField(
                  controller: _userid,
                  obscureText: false,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.admin_panel_settings),
                      border: InputBorder.none,
                      labelText: "User ID",
                      hintText: "Your identity"),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [Colors.amber, Colors.pink]),
                    borderRadius: BorderRadius.circular(20.0)),
                child: TextField(
                  controller: _username,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      border: InputBorder.none,
                      labelText: "Username",
                      hintText: "Username"),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [Colors.amber, Colors.pink]),
                    borderRadius: BorderRadius.circular(20.0)),
                child: TextField(
                  controller: _password,
                  obscureText: true,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.password),
                      border: InputBorder.none,
                      labelText: "Password",
                      hintText: "Password"),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Material(
                borderRadius: BorderRadius.circular(20.0),
                elevation: 10.0,
                color: Colors.pink,
                child: MaterialButton(
                  onPressed: () {
                    insertApi();
                  },
                  child: const Text("REGISTER"),
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Center(
                child: Text(msg, style: const TextStyle(color: Colors.red)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
