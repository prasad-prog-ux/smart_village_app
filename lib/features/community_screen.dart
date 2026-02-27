import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F5F9),
      appBar: AppBar(
        title: const Text("Community"),
        backgroundColor: const Color(0xFF1B5E20),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [

          /// Community Groups
          _CommunityCard(
            icon: "assets/icons/user-group.svg",
            title: "Youth Club",
            subtitle: "Active Members: 45",
          ),

          _CommunityCard(
            icon: "assets/icons/user-group.svg",
            title: "Farmers Group",
            subtitle: "Weekly Meetings - Sunday",
          ),

          _CommunityCard(
            icon: "assets/icons/user-group.svg",
            title: "Self Help Group",
            subtitle: "Women Empowerment Program",
          ),

          SizedBox(height: 25),

          /// Quick Action Section
          Text(
            "Quick Actions",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 15),

          _CommunityCard(
            icon: "assets/icons/chat.svg",
            title: "Open Community Chat",
            subtitle: "Discuss with villagers",
          ),

          _CommunityCard(
            icon: "assets/icons/calendar.svg",
            title: "Upcoming Events",
            subtitle: "View village activities",
          ),
        ],
      ),
    );
  }
}

class _CommunityCard extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;

  const _CommunityCard({
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