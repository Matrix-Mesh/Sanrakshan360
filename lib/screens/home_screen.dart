import 'package:flutter/material.dart';
import 'package:s360/widgets/nav_bar.dart'; // Import the NavBar
import 'package:s360/screens/location_screen.dart'; // Import ChatScreen
import 'package:s360/screens/sos_screen.dart'; // Import SosScreen
import 'package:s360/screens/help_screen.dart'; // Import HelpScreen
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
        title: Text("Home Screen"),
        backgroundColor: Color(0xff6D28D9),
        centerTitle: true,
      ),
      body:const Center(
        child: Text(
          "Home Tab",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
