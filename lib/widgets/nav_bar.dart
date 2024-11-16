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
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.pink,Colors.pinkAccent],
        ),
      ),
      child: BottomAppBar(
        elevation: 0,
        color: Colors.transparent,
        child: SizedBox(
          height: 56,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconBottomBar(
                  text: "Home",
                  icon: Icons.home,
                  selected: selectedIndex == 0,
                  onPressed: () => _onItemTapped(0), // This works first than the above line
                ),
                IconBottomBar(
                  text: "SOS",
                  icon: Icons.sos_rounded,
                  selected: selectedIndex == 1,
                  onPressed: () => _onItemTapped(1),
                ),
                IconBottomBar(
                  text: "Spot",
                  icon: Icons.location_pin,
                  selected: selectedIndex == 2,
                  onPressed: () => _onItemTapped(2),
                ),
                IconBottomBar(
                  text: "Ask",
                  icon: Icons.assistant,
                  selected: selectedIndex == 3,
                  onPressed: () => _onItemTapped(3),
                ),
                IconBottomBar(
                  text: "Profile",
                  icon: Icons.person,
                  selected: selectedIndex == 4,
                  onPressed: () => _onItemTapped(4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.onItemSelected(index);
  }
}

class IconBottomBar extends StatelessWidget {
  const IconBottomBar(
      {Key? key,
      required this.text,
      required this.icon,
      required this.selected,
      required this.onPressed})
      : super(key: key);

  final String text;
  final IconData icon;
  final bool selected;
  final Function() onPressed;

  final Color primaryColor = const Color(0xff4338CA);
  final Color accentColor = const Color(0xffffffff);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon,
            size: 30,
            color: selected ? accentColor : Colors.white70,
          ),
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            height: .1,
            color: selected ? accentColor : Colors.white70,
          ),
        ),
      ],
    );
  }
}
