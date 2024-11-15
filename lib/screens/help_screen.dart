import 'package:flutter/material.dart';

class ChatBotScreen extends StatelessWidget {
  const ChatBotScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ChatBot"),
        backgroundColor: Color(0xff6D28D9),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          "This is the AI ChatBot Screen",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
