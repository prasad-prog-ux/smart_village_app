import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DirectoryScreen extends StatelessWidget {
  const DirectoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F5F9),
      appBar: AppBar(
        title: const Text("Village Directory"),
        backgroundColor: const Color(0xFF1B5E20),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          _InfoCard(
            icon: "assets/icons/phone.svg",
            title: "Police Station",
            subtitle: "100",
          ),
          _InfoCard(
            icon: "assets/icons/phone.svg",
            title: "Hospital",
            subtitle: "102",
          ),
          _InfoCard(
            icon: "assets/icons/phone.svg",
            title: "Fire Brigade",
            subtitle: "101",
          ),
        ],
      ),
    );
  }
}


class _InfoCard extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withAlpha(15),
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            icon,
            height: 26,
            colorFilter: const ColorFilter.mode(
              Color(0xFF1B5E20),
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(subtitle,
                    style: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey)),
              ],
            ),
          )
        ],
      ),
    );
  }
}