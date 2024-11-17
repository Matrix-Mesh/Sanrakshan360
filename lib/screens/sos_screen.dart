import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:permission_handler/permission_handler.dart';

class SosScreen extends StatefulWidget {
  const SosScreen({Key? key}) : super(key: key);

  @override
  _SosScreenState createState() => _SosScreenState();
}

class _SosScreenState extends State<SosScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _hasPermission = false;

  @override
  void initState() {
    super.initState();
    _checkPermission(); // Check permission when screen loads
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _animation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _checkPermission() async {
    final status = await Permission.sms.status;
    setState(() {
      _hasPermission = status.isGranted;
    });
  }

  Future<void> _requestPermission() async {
    final status = await Permission.sms.request();
    setState(() {
      _hasPermission = status.isGranted;
    });

    if (!status.isGranted) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('SMS Permission Required'),
          content: const Text(
              'SMS permission is needed to send emergency messages. Please enable it in your device settings.'
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: const Text('Open Settings'),
              onPressed: () {
                openAppSettings();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    }
  }

  Future<void> _onButtonPressed() async {
    if (!_hasPermission) {
      await _requestPermission();
      return;
    }

    _controller.forward().then((_) {
      _controller.reverse();
    });
    await _sendSMS("I am in danger! Please help me.", ["7678654940"]);
  }

  Future<void> _sendSMS(String message, List<String> recipients) async {
    try {
      String _result = await sendSMS(
        message: message,
        recipients: recipients,
        sendDirect: true,
      );
      print("SMS Result: $_result");

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Emergency message sent successfully'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (error) {
      print("Error sending SMS: $error");
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to send emergency message. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'SOS',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _onButtonPressed,
                  child: ScaleTransition(
                    scale: _animation,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          'SOS',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  _hasPermission ? 'Press for Emergency' : 'SMS permission is required',
                  style: TextStyle(
                    fontSize: 18,
                    color: _hasPermission ? Colors.grey : Colors.orange,
                  ),
                ),
              ],
            ),
          ),
          if (!_hasPermission)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.all(16),
                color: Colors.orange,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        'SMS permission is required to send emergency messages',
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    TextButton(
                      onPressed: _requestPermission,
                      child: const Text(
                        'Grant Permission',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}