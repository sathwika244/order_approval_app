import 'package:flutter/material.dart';
import '../approved_list.dart';
import '../profile_screen.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: const Color(0xFF0C1A4B),
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: (index) {
  if (index == 1) { // Index of the Approved button
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ApprovedList()),
    );
  } else if (index == 3) { // Index of the Profile button
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfileScreen()),
    );
  }
},

      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.grid_view),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.check_box),
          label: "Approved",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart),
          label: "Pending",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Profile",
        ),
      ],
    );
  }
}
