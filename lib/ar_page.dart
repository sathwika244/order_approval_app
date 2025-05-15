// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'widgets/bottom_nav.dart';

class ARPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(),
      body: Center(
        child: Text('AR Page'),
      ),
    );
  }
}