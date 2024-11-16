import 'package:flutter/material.dart';

class SosScreen extends StatelessWidget {
  const SosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SOS"),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          "This is the SOS Screen",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
