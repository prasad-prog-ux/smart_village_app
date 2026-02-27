import 'package:flutter/material.dart';

class AnnouncementsScreen extends StatelessWidget {
  const AnnouncementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Announcements"),
        backgroundColor: const Color(0xFF1B5E20),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [

          _AnnouncementCard(
            title: "Village Fair This Weekend",
            description: "Join us for cultural programs and food stalls.",
            date: "10 Feb 2026",
          ),

          SizedBox(height: 15),

          _AnnouncementCard(
            title: "Water Supply Schedule Update",
            description: "Water will be available from 6AM to 9AM.",
            date: "8 Feb 2026",
          ),
        ],
      ),
    );
  }
}

class _AnnouncementCard extends StatelessWidget {
  final String title;
  final String description;
  final String date;

  const _AnnouncementCard({
    required this.title,
    required this.description,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 5,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(description,
              style: const TextStyle(
                  color: Colors.grey)),
          const SizedBox(height: 8),
          Text(date,
              style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey)),
        ],
      ),
    );
  }
}