import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatBotScreen> {
  final bool _isTyping = true;
  late TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        elevation: 2,

        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.location_city),
          ),

          title: const Text("Chatbot"),
          actions: [IconButton(onPressed: (){}, icon: Icon(Icons.menu))],
        ),
      body: SafeArea(child: Column(children: [
        Flexible(
          child:ListView.builder(
            itemCount: 6,
            itemBuilder: (context, index){
              return const Text("data will be shown here");
            }),
        ),
        if(_isTyping) ...[
          const SpinKitThreeBounce(
            color: Colors.black,
            size: 18,
            ),

            SizedBox(height: 15,),
            Material(
            color: Colors.grey,

            child: Padding(
              padding: const EdgeInsets.all(8.0),
              
              child: Row(children: [
                Expanded(
                  child: TextField(
                    style: TextStyle(color: Colors.black),
                    controller: textEditingController,
                    onSubmitted: (value){
                    //send something
                    },
                  decoration: const InputDecoration.collapsed(
                    hintText: "How can i help?",
                    hintStyle: TextStyle(color: Colors.grey)
                    ),
                  ),
                ),
                IconButton(onPressed: (){}, icon: Icon(Icons.send, color: Colors.black,))
              ],)
            )
          )
        ]
      ],
      ),
      ),
    );
  }
}
