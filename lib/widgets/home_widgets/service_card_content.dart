import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:s360/widgets/home_widgets/emergency.dart'; // Import Emergency widget
import 'package:s360/widgets/home_widgets/service_cards/bus_service_card.dart';
import 'package:s360/widgets/home_widgets/service_cards/metro_service_card.dart';
import 'package:s360/widgets/home_widgets/service_cards/pharmacy_service_card.dart';
import 'package:s360/widgets/home_widgets/service_cards/police_service_card.dart'; // Import PoliceServiceCard
import 'package:s360/widgets/home_widgets/service_cards/hospital_service_card.dart'; // Import HospitalServiceCard
import 'package:url_launcher/url_launcher.dart';

class HomeBodyContent extends StatelessWidget {
  const HomeBodyContent({Key? key}) : super(key: key);

  static Future<void> openMap(String location) async {
    String googleUrl = "https://www.google.com/maps/search/$location";
    final Uri _url = Uri.parse(googleUrl);

    try {
      await launchUrl(_url);
    } catch (e) {
      Fluttertoast.showToast(msg: "something went wrong!");
    }
  }

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
                PoliceServiceCard(onMapFunction: openMap),
                HospitalServiceCard(onMapFunction: openMap),
                BusServiceCard(onMapFunction: openMap),
                PharmacyServiceCard(onMapFunction: openMap),
                MetroServiceCard(onMapFunction: openMap)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
