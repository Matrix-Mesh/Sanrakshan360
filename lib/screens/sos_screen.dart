import 'package:flutter/material.dart';

class SosScreen extends StatelessWidget {
  const SosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SOS"),
        backgroundColor: Color(0xff6D28D9),
        centerTitle: true,
      ),
      body: const Center(
        child:  Text(
          "This is the SOS Screen",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
