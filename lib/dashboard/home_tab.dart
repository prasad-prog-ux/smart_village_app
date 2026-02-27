import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../features/directory_screen.dart';
import '../features/water_schedule_screen.dart';
import '../features/electricity_status_screen.dart';
import '../features/panchayat_notices_screen.dart';
import '../features/bus_timetable_screen.dart';
import '../features/health_camps_screen.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {

  int population = 8542;
  int activeIssues = 12;
  String weather = "28°C";

  @override
  void initState() {
    super.initState();
    loadVillageStats();
  }

  Future<void> loadVillageStats() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      population = 8725;
      activeIssues = 15;
      weather = "30°C";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F8F4),
      body: SingleChildScrollView(
        child: Column(
          children: [

            /// ================= HERO HEADER =================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 35),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
                image: DecorationImage(
                  image: AssetImage("assets/images/hero.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF2E7D32).withOpacity(0.55),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// TOP ROW
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Smart Village",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Stack(
                          children: [
                            const Icon(
                              Icons.notifications_none,
                              color: Colors.white,
                              size: 26,
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: const Text(
                                  "2",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 8),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),

                    const SizedBox(height: 6),

                    const Text(
                      "Connected • Transparent • Digital",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(height: 25),

                    /// GLASS STATS CONTAINER
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 22, horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _StatItem(
                            title: "Population",
                            value: population.toString(),
                            iconPath: "assets/icons/users.svg",
                          ),
                          _StatItem(
                            title: "Active Issues",
                            value: activeIssues.toString(),
                            iconPath: "assets/icons/exclamation-circle.svg",
                          ),
                          _StatItem(
                            title: "Weather",
                            value: weather,
                            iconPath: "assets/icons/cloud-sun.svg",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            /// ================= TODAY STATUS =================
            SizedBox(
              height: 130,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                children: const [
                  _StatusCard(
                    icon: "assets/icons/droplet.svg",
                    title: "Water Today",
                    subtitle: "7AM - 9AM",
                    live: true,
                  ),
                  _StatusCard(
                    icon: "assets/icons/bolt.svg",
                    title: "Electricity",
                    subtitle: "No Outage",
                  ),
                  _StatusCard(
                    icon: "assets/icons/heart.svg",
                    title: "Health Camp",
                    subtitle: "15 Feb",
                  ),
                  _StatusCard(
                    icon: "assets/icons/megaphone.svg",
                    title: "Latest Notice",
                    subtitle: "Village Fair",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 35),

            /// ================= RECENT UPDATES =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Recent Updates",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 18),
                  _UpdateCard(
                    icon: "assets/icons/megaphone.svg",
                    title: "Village Fair This Weekend",
                    date: "10 Feb 2026",
                    category: "Notice",
                  ),
                  SizedBox(height: 14),
                  _UpdateCard(
                    icon: "assets/icons/droplet.svg",
                    title: "New Water Supply Schedule",
                    date: "8 Feb 2026",
                    category: "Water",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 35),

            /// ================= SERVICES GRID =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 1.05,
                children: const [

                  _FeatureCard(
                    iconPath: "assets/icons/phone.svg",
                    label: "Directory",
                    subtitle: "Village Contacts",
                    screen: DirectoryScreen(),
                  ),

                  _FeatureCard(
                    iconPath: "assets/icons/droplet.svg",
                    label: "Water Schedule",
                    subtitle: "Supply Timing",
                    screen: WaterScheduleScreen(),
                  ),

                  _FeatureCard(
                    iconPath: "assets/icons/bolt.svg",
                    label: "Electricity",
                    subtitle: "Outage Updates",
                    screen: ElectricityStatusScreen(),
                  ),

                  _FeatureCard(
                    iconPath: "assets/icons/megaphone.svg",
                    label: "Notices",
                    subtitle: "Panchayat Updates",
                    screen: PanchayatNoticesScreen(),
                  ),

                  _FeatureCard(
                    iconPath: "assets/icons/bus.svg",
                    label: "Bus Timetable",
                    subtitle: "Live Tracking",
                    screen: BusTimetableScreen(),
                  ),

                  _FeatureCard(
                    iconPath: "assets/icons/heart.svg",
                    label: "Health Camps",
                    subtitle: "Medical Events",
                    screen: HealthCampsScreen(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
//iske baad ka code same rhega uper chnages hoga sirf

/// ================= STAT ITEM =================
class _StatItem extends StatelessWidget {
  final String title;
  final String value;
  final String iconPath;

  const _StatItem({
    required this.title,
    required this.value,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          iconPath,
          height: 24,
          colorFilter:
          const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
        const SizedBox(height: 6),
        Text(value,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        const SizedBox(height: 4),
        Text(title,
            style: const TextStyle(
                fontSize: 12,
                color: Colors.white70)),
      ],
    );
  }
}

/// ================= STATUS CARD =================
class _StatusCard extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final bool live;

  const _StatusCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.live = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withAlpha(20),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [

          /// Accent Line
          Container(
            width: 4,
            height: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF1B5E20),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(22),
                bottomLeft: Radius.circular(22),
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SvgPicture.asset(
                    icon,
                    height: 26,
                    colorFilter: const ColorFilter.mode(
                      Color(0xFF1B5E20),
                      BlendMode.srcIn,
                    ),
                  ),

                  const Spacer(),

                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600)),

                  const SizedBox(height: 4),

                  Row(
                    children: [
                      if (live)
                        Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.only(right: 6),
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                      Text(subtitle,
                          style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// ================= FEATURE CARD =================
class _FeatureCard extends StatelessWidget {
  final String iconPath;
  final String label;
  final String subtitle;
  final Widget screen;

  const _FeatureCard({
    required this.iconPath,
    required this.label,
    required this.subtitle,
    required this.screen,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => screen),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFFFFFF), Color(0xFFE8F5E9)],
          ),
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.green.withAlpha(20),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              height: 32,
              colorFilter: const ColorFilter.mode(
                Color(0xFF1B5E20),
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 12),
            Text(label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            Text(subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

/// ================= UPDATE CARD =================
class _UpdateCard extends StatelessWidget {
  final String icon;
  final String title;
  final String date;
  final String category;

  const _UpdateCard({
    required this.icon,
    required this.title,
    required this.date,
    required this.category,
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
            height: 22,
            colorFilter: const ColorFilter.mode(
              Color(0xFF1B5E20),
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1B5E20)
                            .withAlpha(25),
                        borderRadius:
                        BorderRadius.circular(20),
                      ),
                      child: Text(category,
                          style: const TextStyle(
                              fontSize: 11,
                              color:
                              Color(0xFF1B5E20))),
                    ),
                    const SizedBox(width: 10),
                    Text(date,
                        style: const TextStyle(
                            fontSize: 11,
                            color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios,
              size: 14, color: Colors.grey),
        ],
      ),
    );
  }
}