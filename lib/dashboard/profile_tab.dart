import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_village_app/screens/auth/login_screen.dart';
import '../../main.dart'; // for themeNotifier

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {

  bool notificationsEnabled = true;
  bool darkMode = false;

  String userName = "Prasad Mahajan";
  String role = "Village Member";

  @override
  Widget build(BuildContext context) {

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : const Color(0xFFF4F6F8),
      body: Column(
        children: [

          /// HEADER
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 30),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: const Text(
              "My Profile",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 25),

          /// PROFILE CARD
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[900] : Colors.white,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withAlpha(30),
                    blurRadius: 6,
                  )
                ],
              ),
              child: Row(
                children: [

                  CircleAvatar(
                    radius: 35,
                    backgroundColor: const Color(0xFFE8F5E9),
                    child: SvgPicture.asset(
                      "assets/icons/user-circle.svg",
                      height: 40,
                      colorFilter: const ColorFilter.mode(
                          Color(0xFF1B5E20), BlendMode.srcIn),
                    ),
                  ),

                  const SizedBox(width: 20),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        role,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),

          const SizedBox(height: 25),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [

                _profileTile(
                  icon: "pencil-square.svg",
                  title: "Edit Profile",
                  onTap: _editProfile,
                ),

                _switchTile(
                  icon: "bell.svg",
                  title: "Notifications",
                  value: notificationsEnabled,
                  onChanged: (val) {
                    setState(() {
                      notificationsEnabled = val;
                    });
                  },
                ),

                _switchTile(
                  icon: "moon.svg",
                  title: "Dark Mode",
                  value: darkMode,
                  onChanged: (val) {
                    setState(() {
                      darkMode = val;
                      themeNotifier.value =
                      val ? ThemeMode.dark : ThemeMode.light;
                    });
                  },
                ),

                _profileTile(
                  icon: "question-mark-circle.svg",
                  title: "Help & Support",
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text("Help & Support"),
                        content: const Text(
                            "For assistance contact village office."),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("OK"),
                          )
                        ],
                      ),
                    );
                  },
                ),

                _profileTile(
                  icon: "arrow-right-on-rectangle.svg",
                  title: "Logout",
                  iconColor: Colors.red,
                  textColor: Colors.red,
                  onTap: _confirmLogout,
                ),

                const SizedBox(height: 40),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _profileTile({
    required String icon,
    required String title,
    required VoidCallback onTap,
    Color iconColor = const Color(0xFF1B5E20),
    Color textColor = Colors.black,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: ListTile(
        leading: SvgPicture.asset(
          "assets/icons/$icon",
          height: 22,
          colorFilter:
          ColorFilter.mode(iconColor, BlendMode.srcIn),
        ),
        title: Text(
          title,
          style: TextStyle(color: textColor),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  Widget _switchTile({
    required String icon,
    required String title,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: SwitchListTile(
        secondary: SvgPicture.asset(
          "assets/icons/$icon",
          height: 22,
          colorFilter: const ColorFilter.mode(
              Color(0xFF1B5E20), BlendMode.srcIn),
        ),
        title: Text(title),
        value: value,
        onChanged: onChanged,
      ),
    );
  }

  void _editProfile() {
    TextEditingController controller =
    TextEditingController(text: userName);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit Name"),
        content: TextField(
          controller: controller,
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                userName = controller.text;
              });
              Navigator.pop(context);
            },
            child: const Text("Save"),
          )
        ],
      ),
    );
  }

  void _confirmLogout() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Logout"),
        content: const Text("Are you sure?"),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel")),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (_) => const LoginScreen()),
              );
            },
            child: const Text("Logout"),
          )
        ],
      ),
    );
  }
}