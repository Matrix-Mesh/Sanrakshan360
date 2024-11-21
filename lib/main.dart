import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:s360/screens/home_screen.dart';
import 'package:s360/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Auth import

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong.'));
          } else if (snapshot.hasData) {
            // User is logged in, navigate to HomeScreen
            String userName =
                snapshot.data?.displayName ?? snapshot.data?.email ?? 'User';
            String userEmail = snapshot.data?.email ?? 'No Email'; // Pass email
            return HomeScreen(userName: userName, userEmail: userEmail);
          } else {
            // User is not logged in, navigate to LoginScreen
            return LoginScreen();
          }
        },
      ),
    );
  }
}
