import 'package:flutter/material.dart';
import 'package:s360/widgets/nav_bar.dart'; // Import the NavBar
import 'package:s360/screens/chat_screen.dart'; // Import ChatScreen
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

  // Update AppBar based on selected tab
  AppBar _getAppBar() {
    switch (_selectedIndex) {
      case 0:
        return AppBar(
          title: const Text('Home'),
          centerTitle: true,
          backgroundColor: const Color(0xff4338CA),
        );
      case 1:
        return AppBar(
          title: const Text('Chat'),
          centerTitle: true,
          backgroundColor: const Color(0xff4338CA),
        );
      case 2:
        return AppBar(
          title: const Text('SOS'),
          centerTitle: true,
          backgroundColor: const Color(0xff4338CA),
        );
      case 3:
        return AppBar(
          title: const Text('Help'),
          centerTitle: true,
          backgroundColor: const Color(0xff4338CA),
        );
      case 4:
        return AppBar(
          title: const Text('Profile'),
          centerTitle: true,
          backgroundColor: const Color(0xff4338CA),
        );
      default:
        return AppBar(
          title: const Text('Women Safety App'),
          centerTitle: true,
          backgroundColor: const Color(0xff4338CA),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(), // Use dynamic AppBar
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
        return const ChatScreen(); // Chat page
      case 2:
        return const SosScreen(); // SOS page
      case 3:
        return const HelpScreen(); // Help page
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
    return Center(
      child: Text(
        'Home Screen Content',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
