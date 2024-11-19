import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const SOSApp());

class SOSApp extends StatelessWidget {
  const SOSApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SOS Emergency App',
      theme: ThemeData(
        primarySwatch: Colors.red,
        useMaterial3: true,
      ),
      home: const SOSHomePage(),
    );
  }
}

class SOSHomePage extends StatefulWidget {
  const SOSHomePage({Key? key}) : super(key: key);

  @override
  _SOSHomePageState createState() => _SOSHomePageState();
}

class _SOSHomePageState extends State<SOSHomePage> {
  bool _isLoading = false;
  
  // Emergency contacts with name, phone, and type
  final List<Map<String, String>> emergencyContacts = [
    {
      'name': 'Police',
      'phone': '911',
      'type': 'emergency'
    },
    {
      'name': 'Emergency Contact 1',
      'phone': '+917838159080',
      'type': 'contact'
    },
    {
      'name': 'Emergency Contact 2',
      'phone': '+9876543210',
      'type': 'contact'
    },
  ];

  Future<Position?> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location services are disabled')),
        );
        return null;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')),
          );
          return null;
        }
      }

      return await Geolocator.getCurrentPosition();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error getting location: $e')),
      );
      return null;
    }
  }

  Future<void> _makeEmergencyCall(String number) async {
    final Uri url = Uri.parse('tel:$number');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not launch emergency call')),
      );
    }
  }

  Future<void> _sendSOSMessage(String number, Position position) async {
    final message = 'EMERGENCY: I need help! '
        'My location: https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}';
    
    final Uri smsUri = Uri.parse('sms:$number?body=${Uri.encodeComponent(message)}');
    
    if (await canLaunchUrl(smsUri)) {
      await launchUrl(smsUri);
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open SMS app')),
      );
    }
  }

  Future<void> _sendWhatsAppMessage(String number, Position position) async {
    // Remove any non-numeric characters from the phone number
    String cleanNumber = number.replaceAll(RegExp(r'[^\d+]'), '');
    
    final message = 'EMERGENCY: I need help! '
        'My location: https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}';
    
    final whatsappUrl = Uri.parse(
      'whatsapp://send?phone=$cleanNumber&text=${Uri.encodeComponent(message)}'
    );
    
    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl);
    } else {
      // Fallback to web WhatsApp
      final webWhatsappUrl = Uri.parse(
        'https://wa.me/$cleanNumber/?text=${Uri.encodeComponent(message)}'
      );
      if (await canLaunchUrl(webWhatsappUrl)) {
        await launchUrl(webWhatsappUrl);
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open WhatsApp')),
        );
      }
    }
  }

  Future<void> _showEmergencyOptions(Position position) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...emergencyContacts.map((contact) => ListTile(
                leading: Icon(
                  contact['type'] == 'emergency' ? Icons.emergency : Icons.contact_phone,
                  color: contact['type'] == 'emergency' ? Colors.red : Colors.green,
                ),
                title: Text(contact['name']!),
                subtitle: Text(contact['phone']!),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.phone),
                      color: Colors.green,
                      onPressed: () {
                        Navigator.pop(context);
                        _makeEmergencyCall(contact['phone']!);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.message),
                      color: Colors.blue,
                      onPressed: () {
                        Navigator.pop(context);
                        _sendSOSMessage(contact['phone']!, position);
                      },
                    ),
                    if (contact['type'] == 'contact')
                      IconButton(
                        icon:  Icon(Icons.message),
                        color: Colors.green,
                        onPressed: () {
                          Navigator.pop(context);
                          _sendWhatsAppMessage(contact['phone']!, position);
                        },
                      ),
                  ],
                ),
              )).toList(),
            ],
          ),
        );
      },
    );
  }

  void _triggerSOS() async {
    setState(() {
      _isLoading = true;
    });

    try {
      Position? position = await _getCurrentLocation();
      
      if (position != null && mounted) {
        _showEmergencyOptions(position);
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _manageContacts() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController nameController = TextEditingController();
        TextEditingController phoneController = TextEditingController();
        
        return AlertDialog(
          title: const Text('Emergency Contacts'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...emergencyContacts.where((c) => c['type'] == 'contact').map(
                  (contact) => ListTile(
                    title: Text(contact['name']!),
                    subtitle: Text(contact['phone']!),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          emergencyContacts.remove(contact);
                        });
                        Navigator.pop(context);
                        _manageContacts();
                      },
                    ),
                  ),
                ),
                const Divider(),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Contact Name',
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    prefixText: '+',
                  ),
                  keyboardType: TextInputType.phone,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                if (nameController.text.isNotEmpty && 
                    phoneController.text.isNotEmpty) {
                  setState(() {
                    emergencyContacts.add({
                      'name': nameController.text,
                      'phone': '+${phoneController.text}',
                      'type': 'contact'
                    });
                  });
                  Navigator.pop(context);
                  _manageContacts();
                }
              },
            ),
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency SOS'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isLoading)
              const CircularProgressIndicator(color: Colors.red)
            else
              GestureDetector(
                onLongPress: _triggerSOS,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      'HOLD\nFOR\nSOS',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              icon: const Icon(Icons.contacts),
              label: const Text('Manage Emergency Contacts'),
              onPressed: _manageContacts,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[800],
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}