import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Color(0xff6D28D9),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          "This is the Profile Screen",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
