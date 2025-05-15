// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'first_page.dart';
import 'login_page.dart';
import 'home_page.dart';
import 'parts_page.dart';
import 'parts_details.dart';
import 'cost_sheet.dart';
import 'ar_page.dart';
import 'logout_page.dart';
import 'notification_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sales Enquiry Approval',
      initialRoute: '/',
      routes: {
        '/': (context) => FirstPage(),
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/parts': (context) => PartsPage(),
        '/parts_details': (context) => PartsDetails(part: 'A'),
        '/cost_sheet': (context) => CostSheetPage(),
        '/ar': (context) => ARPage(),
        '/logout': (context) => LogoutPage(),
        
        '/notifications': (context) => NotificationPage(),
      },
    );
  }
}
