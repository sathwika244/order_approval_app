import 'package:flutter/material.dart';

class PendingOrdersPage extends StatelessWidget {
  const PendingOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pending Orders"), backgroundColor: Color(0xFF0C1A4B)),
      body: const Center(child: Text("List of pending orders here")),
    );
  }
}
