import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class PartsDetails extends StatelessWidget {
  final String part; // Add this variable to accept part name

  // Constructor to accept part
  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  PartsDetails({required this.part});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavBar(),
      body: Column(
        children: [
          // Header
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: Color(0xFF0C1A4B),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 50,
                  left: 15,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        // ignore: deprecated_member_use
                        backgroundColor: Colors.white.withOpacity(0.2),
                        radius: 40,
                        child: Text(
                          "PART $part", // Show selected part
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Parts Details
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Parts",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Color(0xFF0C1A4B),
                      radius: 12,
                      child: Text(
                        part, // Show selected part
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text("SI#"),
                Text("Quantity"),
                Text("Rate"),
                Text("Value"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Bottom Navigation Bar Widget
// ignore: use_key_in_widget_constructors
class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Color(0xFF0C1A4B),
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
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
