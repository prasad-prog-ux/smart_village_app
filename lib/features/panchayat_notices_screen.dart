import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PanchayatNoticesScreen extends StatefulWidget {
  const PanchayatNoticesScreen({super.key});

  @override
  State<PanchayatNoticesScreen> createState() =>
      _PanchayatNoticesScreenState();
}

class _PanchayatNoticesScreenState
    extends State<PanchayatNoticesScreen> {

  String selectedCategory = "All";
  String searchQuery = "";

  final List<Map<String, dynamic>> notices = [
    {
      "title": "Village Fair Announcement",
      "description":
      "Annual village fair will be held near Panchayat ground with cultural programs and food stalls.",
      "date": DateTime(2026, 2, 10),
      "category": "Event",
      "priority": "Important",
      "isNew": true,
    },
    {
      "title": "New Water Policy",
      "description":
      "Updated water distribution rules for summer season have been approved by Panchayat.",
      "date": DateTime(2026, 2, 8),
      "category": "Water",
      "priority": "Regular",
      "isNew": false,
    },
    {
      "title": "Electricity Maintenance Notice",
      "description":
      "Electricity supply will be temporarily suspended for maintenance work in Ward 2.",
      "date": DateTime(2026, 2, 6),
      "category": "Electricity",
      "priority": "Info",
      "isNew": false,
    },
    {
      "title": "Health Camp Organized",
      "description":
      "Free medical checkup and vaccination drive at Primary Health Center from 10AM onwards.",
      "date": DateTime(2026, 2, 5),
      "category": "Health",
      "priority": "Regular",
      "isNew": false,
    },
  ];

  @override
  Widget build(BuildContext context) {

    notices.sort((a, b) => b["date"].compareTo(a["date"]));

    List<Map<String, dynamic>> filteredNotices =
    notices.where((notice) {

      final matchesCategory =
          selectedCategory == "All" ||
              notice["category"] == selectedCategory;

      final matchesSearch = notice["title"]
          .toLowerCase()
          .contains(searchQuery.toLowerCase());

      return matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF2F5F9),
      appBar: AppBar(
        title: const Text("Panchayat Notices"),
        backgroundColor: const Color(0xFF1B5E20),
      ),
      body: Column(
        children: [

          /// SEARCH BAR
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: "Search notices...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          /// CATEGORY FILTER
          SizedBox(
            height: 45,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding:
              const EdgeInsets.symmetric(horizontal: 10),
              children: [
                categoryChip("All"),
                categoryChip("Event"),
                categoryChip("Water"),
                categoryChip("Electricity"),
                categoryChip("Health"),
              ],
            ),
          ),

          const SizedBox(height: 10),

          /// NOTICE LIST
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: filteredNotices.length,
              itemBuilder: (context, index) {
                final item = filteredNotices[index];
                return NoticeCard(
                  title: item["title"],
                  description: item["description"],
                  date: item["date"],
                  category: item["category"],
                  priority: item["priority"],
                  isNew: item["isNew"],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget categoryChip(String category) {
    final bool isSelected = selectedCategory == category;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: ChoiceChip(
        label: Text(category),
        selected: isSelected,
        selectedColor: const Color(0xFF1B5E20),
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
        ),
        onSelected: (_) {
          setState(() {
            selectedCategory = category;
          });
        },
      ),
    );
  }
}

class NoticeCard extends StatefulWidget {
  final String title;
  final String description;
  final DateTime date;
  final String category;
  final String priority;
  final bool isNew;

  const NoticeCard({
    super.key,
    required this.title,
    required this.description,
    required this.date,
    required this.category,
    required this.priority,
    required this.isNew,
  });

  @override
  State<NoticeCard> createState() => _NoticeCardState();
}

class _NoticeCardState extends State<NoticeCard> {

  bool expanded = false;

  Color getPriorityColor(String priority) {
    switch (priority) {
      case "Important":
        return Colors.red;
      case "Regular":
        return Colors.orange;
      case "Info":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {

    final priorityColor = getPriorityColor(widget.priority);

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

          /// PRIORITY STRIP
          Container(
            width: 6,
            height: 170,
            decoration: BoxDecoration(
              color: priorityColor,
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
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  /// TOP ROW
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
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
                          color: priorityColor.withOpacity(0.1),
                          borderRadius:
                          BorderRadius.circular(20),
                        ),
                        child: Text(
                          widget.category,
                          style: TextStyle(
                            fontSize: 11,
                            color: priorityColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  if (widget.isNew)
                    Padding(
                      padding:
                      const EdgeInsets.only(top: 6),
                      child: Container(
                        padding:
                        const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius:
                          BorderRadius.circular(15),
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
                        : widget.description.length >
                        90
                        ? widget.description
                        .substring(0, 90) +
                        "..."
                        : widget.description,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 13),
                  ),

                  if (widget.description.length > 90)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          expanded = !expanded;
                        });
                      },
                      child: Padding(
                        padding:
                        const EdgeInsets.only(
                            top: 6),
                        child: Text(
                          expanded
                              ? "Read less"
                              : "Read more",
                          style: TextStyle(
                              color: priorityColor,
                              fontWeight:
                              FontWeight.w600),
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