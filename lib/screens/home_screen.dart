import 'package:flutter/material.dart';
import 'package:s360/widgets/home_widgets/emergency.dart';
import 'package:s360/widgets/nav_bar.dart'; // Import the NavBar
import 'package:s360/screens/location_screen.dart'; // Import ChatScreen
import 'package:s360/screens/sos_screen.dart'; // Import SosScreen
import 'package:s360/screens/chatbot_screen.dart'; // Import HelpScreen
import 'package:s360/screens/profile_screen.dart'; // Import ProfileScreen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(), // HomeScreen is the main widget
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Function to handle item selection from NavBar
  void _onNavItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getPage(_selectedIndex), // Display the selected page
      bottomNavigationBar:
          NavBar(onItemSelected: _onNavItemSelected), // Pass the callback
    );
  }

  // Return the selected page based on the index
  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return const HomeContent(); // Home page content (not HomeScreen itself)
      case 1:
        return const SosScreen(); // Chat page
      case 2:
        return const LocationScreen(); // SOS page
      case 3:
        return const ChatBotScreen(); // Help page
      case 4:
        return const ProfileScreen(); // Profile page
      default:
        return const HomeContent(); // Default to Home content
    }
  }
}

// A simple HomeContent widget for the Home tab content
class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hi , Pranjal',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
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
                    style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold)),
                  ),
                  Emergency()
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
                children: [
                  _buildServiceCard(
                    'Police Stations',
                    'assets/police-station.png',
                    Color(0xFFFD8080),
                    Color(0xFFFB8580),
                  ),
                  _buildServiceCard(
                    'Hospitals',
                    'assets/hospital.png',
                    Color(0xFFFD8080),
                    Color(0xFFFB8580),
                  ),
                  _buildServiceCard(
                    'Bus Stations',
                    'assets/bus-stop.png',
                    Color(0xFFFD8080),
                    Color(0xFFFB8580),
                  ),
                  _buildServiceCard(
                    'Pharmacies',
                    'assets/pharmacy.png',
                    Color(0xFFFD8080),
                    Color(0xFFFB8580),
                  ),
                  _buildServiceCard(
                    'Metro Stations',
                    'assets/metro-station.png',
                    Color(0xFFFD8080),
                    Color(0xFFFB8580),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

 Widget _buildServiceCard(
  String title,
  dynamic icon, // Now accepts both IconData and String (for asset path)
  Color startColor,
  Color endColor,
) {
  return Card(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    child: InkWell(
      onTap: () {
        // Add navigation to maps/location functionality here
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