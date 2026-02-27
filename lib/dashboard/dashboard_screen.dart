import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'home_tab.dart';
import 'complaints_tab.dart';
import 'chat_tab.dart';
import 'schemes_tab.dart';
import 'profile_tab.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeTab(),
    const ComplaintsTab(),
    const ChatTab(),
    const SchemesTab(),
    const ProfileTab(),
  ];

  BottomNavigationBarItem buildNavItem(
      String iconPath, int index, String label) {

    final bool isSelected = _currentIndex == index;

    return BottomNavigationBarItem(
      icon: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF1B5E20).withAlpha(38) // soft green bg
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: SvgPicture.asset(
          iconPath,
          height: 22,
          colorFilter: ColorFilter.mode(
            isSelected
                ? const Color(0xFF1B5E20)
                : Colors.grey,
            BlendMode.srcIn,
          ),
        ),
      ),
      label: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFF1B5E20),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          buildNavItem("assets/icons/home.svg", 0, "Home"),
          buildNavItem("assets/icons/complaints.svg", 1, "Complaints"),
          buildNavItem("assets/icons/chat.svg", 2, "Chat"),
          buildNavItem("assets/icons/schemes.svg", 3, "Schemes"),
          buildNavItem("assets/icons/profile.svg", 4, "Profile"),
        ],
      ),
    );
  }
}