import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ApprovedList extends StatelessWidget {
  const ApprovedList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Approved Orders'),
        backgroundColor: Color(0xFF0C1A4B),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .where('status', isEqualTo: 'Approved')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final approvedOrders = snapshot.data!.docs;

          if (approvedOrders.isEmpty) {
            return const Center(child: Text('No approved orders yet.'));
          }

          return ListView.builder(
            itemCount: approvedOrders.length,
            itemBuilder: (context, index) {
              final order = approvedOrders[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text('Order: ${order['productName']}'),
                  subtitle: Text('Customer: ${order['customerName']}'),
                  trailing: const Icon(Icons.check_circle, color: Colors.green),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
