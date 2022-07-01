import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './api.dart';
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

  String baseUrl = Api.baseurl+Api.regis;

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
    final url_ = Uri.parse(baseUrl);
    var body = json.encode(
        {
          'user_id': _userid.text,
          'username': _username.text,
          'password': _password.text
        }
    );
    final res = await http.post(url_,
        headers: {"Content-Type": "application/json"},
        body: body);

    final dataJson = jsonDecode(res.body);
    print(res);
    _userid.clear();
    _username.clear();
    _password.clear();
    _level.clear();

    if (dataJson['status'] == 1) {
      print(dataJson['msg']);
      showDialog(
          context: context,
          builder: (c) {
            return AlertDialog(
              title: const Text("Notification"),
              content: Text(dataJson['msg']),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Close"),
                )
              ],
            );
          });
      setState(() {
        msg = dataJson['msg'];
      });
    } else if (dataJson['status'] == 2) {
      print(dataJson['msg']);
      Navigator.of(context).pop();
      setState(() {
        msg = "";
      });
    } else {
      print(dataJson['msg']);
      setState(() {
        msg = dataJson['msg'];
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
                    gradient:
                    const LinearGradient(colors: [Colors.amber, Colors.pink]),
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
                    gradient:
                        const LinearGradient(colors: [Colors.amber, Colors.pink]),
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
                    gradient:
                        const LinearGradient(colors: [Colors.amber, Colors.pink]),
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
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      gradient:
                          LinearGradient(colors: [Colors.amber, Colors.pink]),
                      borderRadius: BorderRadius.circular(20.0)),
                  child: ListTile(
                      trailing: DropdownButton(
                        items: _myitems,
                        value: valueItem,
                        onChanged: (e) {
                          setState(() {
                            valueItem;
                          });
                        },
                      ))),
              const SizedBox(
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
