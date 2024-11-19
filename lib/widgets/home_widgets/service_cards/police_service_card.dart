import 'package:flutter/material.dart';

class PoliceServiceCard extends StatelessWidget {
  final Function? onMapFunction;

  const PoliceServiceCard({Key? key, this.onMapFunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildServiceCard(
      title: 'Police Stations',
      icon: 'assets/police-station.png',
      startColor: Color(0xFFFD8080),
      endColor: Color(0xFFFB8580),
    );
  }

  Widget _buildServiceCard({
    required String title,
    required dynamic icon, // Accepts both icon data or image asset path
    required Color startColor,
    required Color endColor,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          onMapFunction!("police stations near me");
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft, // Start from top-left
              end: Alignment.bottomRight, // End at bottom-right
              colors: [startColor, endColor], // Gradient colors
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Check if icon is a string (image path)
              icon is String
                  ? Image.asset(
                      icon, // This is the asset path
                      width: 50, // Set the width of the image
                      height: 50, // Set the height of the image
                    )
                  : Icon(
                      icon, // Fallback to Icon if it's not a string
                      size: 48,
                      color: Colors.white,
                    ),
              const SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
