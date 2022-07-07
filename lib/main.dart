import 'dart:convert';
import 'home.dart';
import 'package:flutter/material.dart';
import 'api.dart';
import 'package:http/http.dart' as http;
import 'register.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Login Local Server",
    home: Login(),
  ));
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String apiUrl = Api.baseurl + Api.login;

  String msgError = "";
  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  getApi(String username, String password) async {
    var body = {
      'username': username,
      'password': password,
    };
    var response = await http.post(Uri.parse(apiUrl), body: json.encode(body));
    var dataJson = response.body;
    if (response.statusCode == 200) {
      var data = json.decode(dataJson);
      if (data['status'] == 'success') {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    HomePage(username: data['data']['username'])));
      } else {
        setState(() {
          msgError = data['message'];
        });
      }
    }
  }

  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
          backgroundColor: Colors.red,
          elevation: 0.5,
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const RegisterPage()));
              },
              child: const Text("Register"),
              splashColor: Colors.amber,
              highlightColor: Colors.amber,
            )
          ],
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
                    controller: _username,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
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
                    autofocus: true,
                    obscureText: true,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        border: InputBorder.none,
                        labelText: "Password",
                        hintText: "Password"),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Material(
                  borderRadius: BorderRadius.circular(20.0),
                  elevation: 10.0,
                  color: Colors.pink,
                  child: MaterialButton(
                    onPressed: () {
                      getApi(_username.text, _password.text);
                    },
                    child: const Text("Login"),
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Center(
                  child:
                      Text(msgError, style: const TextStyle(color: Colors.red)),
                )
              ],
            ),
          ),
        ));
  }
}
