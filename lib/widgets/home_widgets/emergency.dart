import 'package:flutter/material.dart';
import 'emergencies/PoliceEmergency.dart';
import 'emergencies/AmbulanceEmergency.dart';
import 'emergencies/WomanEmergency.dart';
import 'emergencies/FirebrigadeEmergency.dart';

class Emergency extends StatelessWidget {
  const Emergency({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 180,
      child: ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          PoliceEmergency(),
          WomanEmergency(),
          AmbulanceEmergency(),
          FirebrigadeEmergency(),
        ],
      ),
    );
  }
}