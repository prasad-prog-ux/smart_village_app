import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BusTimetableScreen extends StatefulWidget {
  const BusTimetableScreen({super.key});

  @override
  State<BusTimetableScreen> createState() => _BusTimetableScreenState();
}

class _BusTimetableScreenState extends State<BusTimetableScreen> {

  double bus1Progress = 0.20; // Near Stop 1
  double bus2Progress = 0.65; // Near Stop 3
  bool bus1Arrived = false;
  bool bus2Arrived = false;

  final double totalDistance = 40;

  final List<String> stops = [
    "Village",
    "Green Farm",
    "Highway Point",
    "City"
  ];

  @override
  void initState() {
    super.initState();
    startTracking();
  }
  void showArrivalPopup(String message) {

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text("Bus Arrived 🚍"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("OK"),
          )
        ],
      ),
    );
  }

  void startTracking() {
    Timer.periodic(const Duration(seconds: 2), (timer) {

      setState(() {

        if (bus1Progress < 1) {
          bus1Progress += 0.02;
          if (bus1Progress >= 1) {
            bus1Progress = 1;
            if (!bus1Arrived) {
              bus1Arrived = true;
              showArrivalPopup("Village → City Bus reached City");
            }
          }
        }

        if (bus2Progress < 1) {
          bus2Progress += 0.015;
          if (bus2Progress >= 1) {
            bus2Progress = 1;
            if (!bus2Arrived) {
              bus2Arrived = true;
              showArrivalPopup("City → Village Bus reached Village");
            }
          }
        }

        if (bus1Progress == 1 && bus2Progress == 1) {
          timer.cancel();
        }

      });

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F5F9),
      appBar: AppBar(
        title: const Text("Bus Tracking"),
        backgroundColor: const Color(0xFF1B5E20),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [

          LiveBusCard(
            route: "Village → City",
            departure: "7:30 AM",
            progress: bus1Progress,
            totalDistance: totalDistance,
            stops: stops,
          ),

          LiveBusCard(
            route: "City → Village",
            departure: "9:00 AM",
            progress: bus2Progress,
            totalDistance: totalDistance,
            stops: stops.reversed.toList(),
          ),

          const SizedBox(height: 30),

          const Text(
            "Scheduled Buses",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 15),

          const NormalBusCard(
            route: "Village → City",
            times: "1:00 PM | 6:00 PM",
          ),

          const NormalBusCard(
            route: "City → Village",
            times: "4:00 PM | 8:00 PM",
          ),
        ],
      ),
    );
  }
}

class LiveBusCard extends StatelessWidget {
  final String route;
  final String departure;
  final double progress;
  final double totalDistance;
  final List<String> stops;

  const LiveBusCard({
    super.key,
    required this.route,
    required this.departure,
    required this.progress,
    required this.totalDistance,
    required this.stops,
  });

  @override
  Widget build(BuildContext context) {

    double distanceLeft = totalDistance * (1 - progress);
    int eta = (distanceLeft * 1.5).toInt();

    int currentStopIndex = (progress * (stops.length - 1)).floor();

    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.3),
            blurRadius: 18,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(route,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: progress >= 1 ? Colors.blue : Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  progress >= 1 ? "ARRIVED" : "LIVE",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              )
            ],
          ),

          const SizedBox(height: 6),
          Text("Departure: $departure",
              style: const TextStyle(color: Colors.white70)),

          const SizedBox(height: 30),

          LayoutBuilder(
            builder: (context, constraints) {

              double width = constraints.maxWidth;

              return Column(
                children: [

                  Stack(
                    children: [

                      Container(
                        height: 4,
                        width: width,
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),

                      Container(
                        height: 4,
                        width: width * progress,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),

                      Positioned(
                        left: (width * progress) - 15,
                        top: -18,
                        child: SvgPicture.asset(
                          "assets/icons/bus.svg",
                          height: 28,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(stops.length, (index) {
                      bool isCurrent = index == currentStopIndex;

                      return Expanded(
                        child: Column(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: isCurrent
                                    ? Colors.yellow
                                    : Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              stops[index],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 11,
                                color: isCurrent
                                    ? Colors.yellow
                                    : Colors.white70,
                                fontWeight: isCurrent
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 25),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _InfoItem(
                title: "Distance Left",
                value: "${distanceLeft.toStringAsFixed(1)} km",
              ),
              _InfoItem(
                title: "ETA",
                value: "$eta mins",
              ),
              _InfoItem(
                title: "Progress",
                value: "${(progress * 100).toInt()}%",
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final String title;
  final String value;

  const _InfoItem({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(title,
            style: const TextStyle(
                color: Colors.white70,
                fontSize: 12)),
      ],
    );
  }
}

class NormalBusCard extends StatelessWidget {
  final String route;
  final String times;

  const NormalBusCard({
    super.key,
    required this.route,
    required this.times,
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
            color: Colors.green.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            "assets/icons/bus.svg",
            height: 24,
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
                Text(route,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(times,
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