import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String username;

  const HomePage({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Home Page"),
          backgroundColor: Colors.pink,
          elevation: 0.5),
      body: Center(
        child: Text("Selamat Datang " + username),
      ),
    );
  }
}
