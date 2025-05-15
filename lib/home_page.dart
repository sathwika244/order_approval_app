// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Map<String, TextEditingController> _remarksControllers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6), // Light background
      bottomNavigationBar: const BottomNavBar(),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(child: _buildOrdersList()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color(0xFF0C1A4B), // Navy blue
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.topLeft,
            child: Text("Welcome Back",
                style: TextStyle(color: Colors.white, fontSize: 18)),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 3),
                )
              ],
            ),
            child: Column(
              children: [
                const Text(
                  "Sales Enquiry Approval",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildIconButton(Icons.build_circle_outlined, "Parts"),
                    _buildIconButton(Icons.description_outlined, "Cost Sheet"),
                    _buildIconButton(Icons.auto_awesome_mosaic_outlined, "AR"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, String label) {
  return GestureDetector(
    onTap: () {
      if (label == "Parts") {
        Navigator.pushNamed(context, '/parts');
      } else if (label == "Cost Sheet") {
        Navigator.pushNamed(context, '/costsheet');
      } else if (label == "AR") {
        Navigator.pushNamed(context, '/ar');
      }
    },
    child: Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFE6ECF3),
            shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(2, 2))
            ],
          ),
          padding: const EdgeInsets.all(10),
          child: Icon(icon, size: 30, color: const Color(0xFF0C1A4B)),
        ),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    ),
  );
}

  

  Widget _buildOrdersList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('orders').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) return Center(child: Text('Error: ${snapshot.error}'));
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final orders = snapshot.data!.docs;

        if (orders.isEmpty) return const Center(child: Text("No orders found"));

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final doc = orders[index];
            final data = doc.data() as Map<String, dynamic>;
            final orderId = doc.id;
            _remarksControllers.putIfAbsent(orderId, () => TextEditingController());

            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 20),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Order: ${data['orderNumber']}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 4),
                    Text("Product: ${data['product']}"),
                    Text("Price: ₹${data['price']}"),
                    Text("Date: ${data['date']}"),
                    Text("Status: ${data['status']}", style: TextStyle(color: _getStatusColor(data['status']))),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _remarksControllers[orderId],
                      decoration: const InputDecoration(
                        hintText: "Enter remarks",
                        filled: true,
                        fillColor: Color(0xFFF3F4F6),
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          icon: const Icon(Icons.check),
                          label: const Text("Accept"),
                          onPressed: () => _updateStatus(orderId, "approved"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0C1A4B),
                            foregroundColor: Colors.white,
                          ),
                        ),
                        OutlinedButton.icon(
                          icon: const Icon(Icons.close),
                          label: const Text("Reject"),
                          onPressed: () => _updateStatus(orderId, "rejected"),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF0C1A4B),
                            side: const BorderSide(color: Color(0xFF0C1A4B)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'approved':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  void _updateStatus(String docId, String newStatus) {
    final remarks = _remarksControllers[docId]?.text ?? "";

    FirebaseFirestore.instance.collection('orders').doc(docId).update({
      'status': newStatus,
      'remarks': remarks,
    }).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Order $newStatus')),
      );
    }).catchError((error) {
      print("Error updating status: $error");
    });
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color(0xFF0C1A4B),
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.check_circle_outline), label: "Approved"),
        BottomNavigationBarItem(icon: Icon(Icons.pending_actions), label: "Pending"),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Profile"),
      ],
    );
  }
}
