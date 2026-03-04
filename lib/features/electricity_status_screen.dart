import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ElectricityStatusScreen extends StatefulWidget {
  const ElectricityStatusScreen({super.key});

  @override
  State<ElectricityStatusScreen> createState() =>
      _ElectricityStatusScreenState();
}

class _ElectricityStatusScreenState
    extends State<ElectricityStatusScreen> {

  bool powerAvailable = true;

  final List<Map<String, dynamic>> wards = [
    {
      "name": "Ward 1",
      "status": "Available",
      "reason": "Normal supply",
    },
    {
      "name": "Ward 2",
      "status": "Maintenance",
      "reason": "Line repair work",
    },
    {
      "name": "Ward 3",
      "status": "Outage",
      "reason": "Transformer fault",
    },
  ];

  final List<Map<String, dynamic>> maintenance = [
    {
      "area": "Ward 2",
      "date": "20 Feb 2026",
      "time": "10:00 AM - 12:00 PM",
      "priority": "Maintenance",
      "reason": "Scheduled electrical inspection",
    },
    {
      "area": "Ward 3",
      "date": "22 Feb 2026",
      "time": "2:00 PM - 4:00 PM",
      "priority": "Emergency",
      "reason": "Transformer replacement",
    },
  ];

  Color getStatusColor(String status) {
    switch (status) {
      case "Available":
        return Colors.green;
      case "Maintenance":
        return Colors.orange;
      case "Outage":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Color getPriorityColor(String priority) {
    switch (priority) {
      case "Emergency":
        return Colors.red;
      case "Maintenance":
        return Colors.orange;
      default:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFF2F5F9),
      appBar: AppBar(
        title: const Text("Electricity Status"),
        backgroundColor: const Color(0xFF1B5E20),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// LIVE STATUS CARD
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/bolt.svg",
                    height: 40,
                    colorFilter: const ColorFilter.mode(
                      Color(0xFF1B5E20),
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Current Status",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: powerAvailable
                                    ? Colors.green
                                    : Colors.red,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              powerAvailable
                                  ? "Electricity Available"
                                  : "Power Cut Active",
                              style: TextStyle(
                                color: powerAvailable
                                    ? Colors.green
                                    : Colors.red,
                                fontWeight:
                                FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 30),

            /// WARD STATUS
            const Text(
              "Ward Status",
              style:
              TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            ...wards.map((ward) {
              final color =
              getStatusColor(ward["status"]);

              return Container(
                margin:
                const EdgeInsets.only(bottom: 15),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    )
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 6,
                      height: 70,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius:
                        BorderRadius.circular(10),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            ward["name"],
                            style: const TextStyle(
                                fontWeight:
                                FontWeight.w600),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            ward["status"],
                            style: TextStyle(
                              color: color,
                              fontWeight:
                              FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            ward["reason"],
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }),

            const SizedBox(height: 25),

            /// MAINTENANCE SCHEDULE
            const Text(
              "Scheduled Maintenance",
              style:
              TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            ...maintenance.map((item) {
              final color =
              getPriorityColor(item["priority"]);

              return ExpandableMaintenanceCard(
                area: item["area"],
                date: item["date"],
                time: item["time"],
                reason: item["reason"],
                priority: item["priority"],
                color: color,
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

class ExpandableMaintenanceCard extends StatefulWidget {
  final String area;
  final String date;
  final String time;
  final String reason;
  final String priority;
  final Color color;

  const ExpandableMaintenanceCard({
    super.key,
    required this.area,
    required this.date,
    required this.time,
    required this.reason,
    required this.priority,
    required this.color,
  });

  @override
  State<ExpandableMaintenanceCard> createState() =>
      _ExpandableMaintenanceCardState();
}

class _ExpandableMaintenanceCardState
    extends State<ExpandableMaintenanceCard> {

  bool expanded = false;

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        children: [

          ListTile(
            leading: Container(
              width: 6,
              height: 40,
              decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            title: Text(widget.area),
            subtitle: Text(
                "${widget.date} • ${widget.time}"),
            trailing: IconButton(
              icon: Icon(
                expanded
                    ? Icons.expand_less
                    : Icons.expand_more,
              ),
              onPressed: () {
                setState(() {
                  expanded = !expanded;
                });
              },
            ),
          ),

          if (expanded)
            Padding(
              padding:
              const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 15),
              child: Text(
                widget.reason,
                style: const TextStyle(
                    color: Colors.grey),
              ),
            ),
        ],
      ),
    );
  }
}