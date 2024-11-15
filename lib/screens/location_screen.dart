import 'package:flutter/material.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Live Location"),
        backgroundColor: Color(0xff6D28D9),
        centerTitle: true,
      ),
      body:const Center(
        child: Text(
          "This is the Location Tracking Screen",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
