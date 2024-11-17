import 'package:flutter/material.dart';
import 'package:s360/widgets/home_widgets/emergency.dart'; // Import Emergency widget
import 'package:s360/widgets/service_cards/bus_service_card.dart';
import 'package:s360/widgets/service_cards/metro_service_card.dart';
import 'package:s360/widgets/service_cards/pharmacy_service_card.dart';
import 'package:s360/widgets/service_cards/police_service_card.dart'; // Import PoliceServiceCard
import 'package:s360/widgets/service_cards/hospital_service_card.dart'; // Import HospitalServiceCard

class HomeBodyContent extends StatelessWidget {
  const HomeBodyContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Emergency Numbers Section
          SizedBox(
            child: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text("Emergency Number",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                const Emergency() // Your Emergency widget goes here
              ],
            ),
          ),
          // Nearby Services Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Nearby Services',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              padding: const EdgeInsets.all(8),
              children: const [
                PoliceServiceCard(),
                HospitalServiceCard(),
                BusServiceCard(),
                PharmacyServiceCard(),
                MetroServiceCard()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
