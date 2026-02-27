import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HealthCampsScreen extends StatelessWidget {
  const HealthCampsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Health Camps"),
        backgroundColor: const Color(0xFF1B5E20),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [

          _HealthCard(
            title: "Free Eye Checkup Camp",
            date: "15 Feb 2026",
          ),

          SizedBox(height: 15),

          _HealthCard(
            title: "Vaccination Drive",
            date: "20 Feb 2026",
          ),
        ],
      ),
    );
  }
}

class _HealthCard extends StatelessWidget {
  final String title;
  final String date;

  const _HealthCard({
    required this.title,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Text(date,
              style: const TextStyle(
                  color: Colors.grey)),
        ],
      ),
    );
  }
}