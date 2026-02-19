import 'package:flutter/material.dart';
import 'screens/auth/landing_screen.dart';

void main() {
  runApp(const GramSetuApp());
}

class GramSetuApp extends StatelessWidget {
  const GramSetuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Gram Setu",
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const LandingScreen(),
    );
  }
}
