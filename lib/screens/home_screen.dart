import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:s360/widgets/home_widgets/service_card_content.dart'; // Import the new HomeBodyContent widget
import 'package:s360/widgets/nav_bar.dart'; // Import the NavBar
import 'package:s360/screens/sos_screen.dart'; // Import SosScreen
import 'package:s360/screens/location_screen.dart'; // Import LocationScreen
import 'package:s360/screens/chatbot_screen.dart'; // Import HelpScreen
import 'package:s360/screens/profile_screen.dart'; // Import ProfileScreen
import 'package:s360/screens/login_screen.dart'; // Import LoginScreen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirebaseAuth.instance.currentUser != null
          ? HomeScreen(
              userName:
                  FirebaseAuth.instance.currentUser!.displayName ?? 'User',
              userEmail: '',
            )
          : LoginScreen(), // If user is logged in, show HomeScreen else show LoginScreen
    );
  }
}

class HomeScreen extends StatefulWidget {
  final String userName;
  final String userEmail;

  const HomeScreen({Key? key, required this.userName, required this.userEmail})
      : super(key: key);

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
        return HomeContent(
            userName: widget.userName); // Pass userName to HomeContent
      case 1:
        return const SOSApp(); // SOS page
      case 2:
        return const LocationScreen(); // Location page
      case 3:
        return const ChatbotScreen(); // Chatbot page
      case 4:
        return ProfileScreen(
            userName: widget.userName,
            userEmail: widget.userEmail); // Profile page
      default:
        return HomeContent(
            userName: widget.userName); // Default to Home content
    }
  }
}

// HomeContent widget to display the userName on the home screen
class HomeContent extends StatelessWidget {
  final String userName;

  const HomeContent({Key? key, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hi, ${userName.isEmpty ? 'User' : userName}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: const HomeBodyContent(), // Replace with your widget content
    );
  }
}
