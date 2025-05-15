// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'parts_details.dart'; // Ensure this file exists

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PartsPage(),
    );
  }
}

class PartsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FAF8),
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: Column(
        children: [
          // Header Section
          Container(
            height: 250,
            decoration: BoxDecoration(
              color: Color(0xFF0C1A4B),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: 50), // Space for status bar
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {},
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "PARTS",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 48), // To balance back button spacing
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 20), // Ensure spacing

          // Data Table Section inside ScrollView
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Parts", style: _tableHeaderStyle()),
                          Text("Sl#", style: _tableHeaderStyle()),
                          Text("Quantity", style: _tableHeaderStyle()),
                          Text("Value", style: _tableHeaderStyle()),
                        ],
                      ),
                      Divider(color: Colors.black87),
                      _buildTableRow(context, "A"),
                      _buildTableRow(context, "B"),
                      _buildTableRow(context, "C"),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableRow(BuildContext context, String part) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PartsDetails(part: part)), // Pass part name
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildCircleItem(part),
            Text("01", style: _tableRowStyle()),
            Text("10", style: _tableRowStyle()),
            Text("\$100", style: _tableRowStyle()),
          ],
        ),
      ),
    );
  }

  Widget _buildCircleItem(String text) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: Color(0xFF0C1A4B),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: Color(0xFF0C1A4B),
      unselectedItemColor: Colors.black45,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.check_box), label: "Approved"),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Pending"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ],
    );
  }

  TextStyle _tableHeaderStyle() {
    return TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black);
  }

  TextStyle _tableRowStyle() {
    return TextStyle(fontSize: 14, color: Colors.black87);
  }
}
