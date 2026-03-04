import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WaterScheduleScreen extends StatefulWidget {
  const WaterScheduleScreen({super.key});

  @override
  State<WaterScheduleScreen> createState() => _WaterScheduleScreenState();
}

class _WaterScheduleScreenState extends State<WaterScheduleScreen> {

  final List<Map<String, String>> schedule = [
    {
      "day": "Monday - Friday",
      "time": "7:00 AM - 9:00 AM",
      "status": "Available"
    },
    {
      "day": "Saturday",
      "time": "6:00 AM - 8:00 AM",
      "status": "Available"
    },
    {
      "day": "Sunday",
      "time": "No Supply",
      "status": "Unavailable"
    },
  ];

  bool isWaterLive(String time) {
    if (time == "No Supply") return false;

    final now = TimeOfDay.now();
    final currentMinutes = now.hour * 60 + now.minute;

    if (time.contains("7:00 AM")) {
      return currentMinutes >= 420 && currentMinutes <= 540;
    }
    if (time.contains("6:00 AM")) {
      return currentMinutes >= 360 && currentMinutes <= 480;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFF2F5F9),
      appBar: AppBar(
        title: const Text("Water Schedule"),
        backgroundColor: const Color(0xFF1B5E20),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [

          /// TOP STATUS CARD
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)],
              ),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  "assets/icons/droplet.svg",
                  height: 40,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 15),
                const Expanded(
                  child: Text(
                    "Today's Water Status",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "Check Below",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
          ),

          const SizedBox(height: 25),

          /// SCHEDULE CARDS
          ...schedule.map((item) {

            final live = isWaterLive(item["time"]!);
            final available = item["status"] == "Available";

            return Container(
              margin: const EdgeInsets.only(bottom: 18),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 5),
                  )
                ],
              ),
              child: Row(
                children: [

                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: available
                          ? Colors.green.withOpacity(0.1)
                          : Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/droplet.svg",
                      height: 26,
                      colorFilter: ColorFilter.mode(
                        available ? Colors.green : Colors.red,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),

                  const SizedBox(width: 15),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          item["day"]!,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item["time"]!,
                          style: const TextStyle(
                              fontSize: 13,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                  ),

                  Column(
                    children: [
                      if (live)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius:
                            BorderRadius.circular(20),
                          ),
                          child: const Text(
                            "LIVE",
                            style: TextStyle(
                                fontSize: 10,
                                color: Colors.white),
                          ),
                        ),
                      const SizedBox(height: 6),
                      Text(
                        available ? "Available" : "No Supply",
                        style: TextStyle(
                            fontSize: 11,
                            color: available
                                ? Colors.green
                                : Colors.red),
                      )
                    ],
                  )
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}