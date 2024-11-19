import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  final void Function(int) onItemSelected;
  const NavBar({Key? key, required this.onItemSelected}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Theme colors extracted from typical safety app palette
    final Color primaryColor = Color(0xFFFF3366); // Vibrant pink-red
    final Color secondaryColor = Color(0xFF5D3FD3); // Deep purple
    final Color backgroundColor = Color(0xFFF5F5F5); // Soft light gray

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -3),
          )
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavItem(
                index: 0,
                icon: Icons.home_rounded,
                label: "Home",
                primaryColor: primaryColor,
                secondaryColor: secondaryColor,
              ),
              _buildNavItem(
                index: 1,
                icon: Icons.emergency_rounded,
                label: "SOS",
                primaryColor: primaryColor,
                secondaryColor: secondaryColor,
              ),
              _buildNavItem(
                index: 2,
                icon: Icons.location_on_rounded,
                label: "Spot",
                primaryColor: primaryColor,
                secondaryColor: secondaryColor,
              ),
              _buildNavItem(
                index: 3,
                icon: Icons.help_outline_rounded,
                label: "Ask",
                primaryColor: primaryColor,
                secondaryColor: secondaryColor,
              ),
              _buildNavItem(
                index: 4,
                icon: Icons.person_rounded,
                label: "Profile",
                primaryColor: primaryColor,
                secondaryColor: secondaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required String label,
    required Color primaryColor,
    required Color secondaryColor,
  }) {
    bool isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
        widget.onItemSelected(index);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 16.0 : 8.0,
          vertical: 8.0,
        ),
        decoration: BoxDecoration(
          color:
              isSelected ? primaryColor.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 28,
              color: isSelected ? primaryColor : Colors.grey.shade600,
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? primaryColor : Colors.grey.shade600,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
