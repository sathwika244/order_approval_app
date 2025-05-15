// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black, size: 28),
          onPressed: () {
            Navigator.pop(context); // Back to Profile Screen
          },
        ),
        title: Text("Notifications", style: TextStyle(color: Colors.black)),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          "No new notifications",
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      ),
    );
  }
}
