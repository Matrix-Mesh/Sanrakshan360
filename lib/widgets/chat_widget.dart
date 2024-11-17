import 'package:flutter/material.dart';
import 'text_widget.dart';
import '../constants/constants.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({super.key, required this.msg, required this.chatIndex});

  final String msg;
  final int chatIndex; 


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(

          color: chatIndex == 0 ?  scaffoldBackgroundColor: cardColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
          
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                chatIndex == 0 ? Icon(Icons.verified_user_sharp, size: 30,):Icon(Icons.bolt, size: 30,),
                const SizedBox(width: 8,),
                Expanded(
                  child:TextWidget(
                  label: msg,

                  )
                ),


                ],
            ),
          ),
        ),
      ],
    );
  }
}