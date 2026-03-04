import 'package:flutter/material.dart';

class AnnouncementsScreen extends StatefulWidget {
  const AnnouncementsScreen({super.key});

  @override
  State<AnnouncementsScreen> createState() => _AnnouncementsScreenState();
}

class _AnnouncementsScreenState extends State<AnnouncementsScreen> {

  final List<Map<String, dynamic>> announcements = [
    {
      "title": "Village Fair This Weekend",
      "description": "Join us for cultural programs, food stalls, and traditional games.\n\ All villagers are invited to participate and enjoy the celebrations.",
      "date": DateTime(2026, 2, 10),
      "category": "Event",
      "isNew": true,
    },
    {
      "title": "Water Supply Schedule Update",
      "description": "Water will now be available from 6AM to 9AM daily due to maintenance work. Please store water accordingly.",
      "date": DateTime(2026, 2, 8),
      "category": "Notice",
      "isNew": false,
    },
    {
      "title": "Health Camp Organized",
      "description": "Free medical checkup and vaccination drive at Primary Health Center from 10AM onwards.",
      "date": DateTime(2026, 2, 6),
      "category": "Health",
      "isNew": false,
    },
    {
      "title": "Electricity Maintenance Alert",
      "description": "Electricity supply will be temporarily interrupted between 2PM to 4PM due to line inspection.",
      "date": DateTime(2026, 2, 5),
      "category": "Alert",
      "isNew": false,
    },
  ];

  @override
  Widget build(BuildContext context) {

    announcements.sort((a, b) => b["date"].compareTo(a["date"]));

    return Scaffold(
      backgroundColor: const Color(0xFFF2F5F9),
      appBar: AppBar(
        title: const Text("Announcements"),
        backgroundColor: const Color(0xFF1B5E20),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: announcements.length,
        itemBuilder: (context, index) {
          final item = announcements[index];
          return AnnouncementCard(
            title: item["title"],
            description: item["description"],
            date: item["date"],
            category: item["category"],
            isNew: item["isNew"],
          );
        },
      ),
    );
  }
}

class AnnouncementCard extends StatefulWidget {
  final String title;
  final String description;
  final DateTime date;
  final String category;
  final bool isNew;

  const AnnouncementCard({
    super.key,
    required this.title,
    required this.description,
    required this.date,
    required this.category,
    required this.isNew,
  });

  @override
  State<AnnouncementCard> createState() => _AnnouncementCardState();
}

class _AnnouncementCardState extends State<AnnouncementCard> {

  bool expanded = false;

  Color getCategoryColor(String category) {
    switch (category) {
      case "Event":
        return Colors.green;
      case "Notice":
        return Colors.blue;
      case "Alert":
        return Colors.red;
      case "Health":
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {

    final categoryColor = getCategoryColor(widget.category);

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
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

          /// LEFT ACCENT STRIP
          Container(
            width: 6,
            height: 150,
            decoration: BoxDecoration(
              color: categoryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(22),
                bottomLeft: Radius.circular(22),
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// TOP ROW
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Expanded(
                        child: Text(
                          widget.title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: categoryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          widget.category,
                          style: TextStyle(
                              fontSize: 11,
                              color: categoryColor,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),

                  if (widget.isNew)
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Text(
                          "NEW",
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.white),
                        ),
                      ),
                    ),

                  const SizedBox(height: 12),

                  Text(
                    expanded
                        ? widget.description
                        : widget.description.length > 80
                        ? widget.description.substring(0, 80) + "..."
                        : widget.description,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 13),
                  ),

                  if (widget.description.length > 80)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          expanded = !expanded;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(
                          expanded ? "Read less" : "Read more",
                          style: TextStyle(
                              color: categoryColor,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),

                  const SizedBox(height: 12),

                  Text(
                    "${widget.date.day}/${widget.date.month}/${widget.date.year}",
                    style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey),
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