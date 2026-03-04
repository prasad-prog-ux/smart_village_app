import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HealthCampsScreen extends StatefulWidget {
  const HealthCampsScreen({super.key});

  @override
  State<HealthCampsScreen> createState() => _HealthCampsScreenState();
}

class _HealthCampsScreenState extends State<HealthCampsScreen> {

  String selectedFilter = "All";
  String searchQuery = "";

  final List<Map<String, dynamic>> camps = [
    {
      "title": "Free Eye Checkup Camp",
      "date": "10 March 2026",
      "time": "10:00 AM - 4:00 PM",
      "location": "Primary Health Center",
      "category": "Eye",
      "status": "Upcoming",
      "description":
      "Free eye testing, vision check, and consultation by certified doctors.",
    },
    {
      "title": "Vaccination Drive",
      "date": "20 March 2026",
      "time": "9:00 AM - 2:00 PM",
      "location": "Village School Hall",
      "category": "Vaccination",
      "status": "Upcoming",
      "description":
      "COVID booster and child vaccination drive. Bring Aadhaar card.",
    },
    {
      "title": "General Health Camp",
      "date": "5 Feb 2026",
      "time": "11:00 AM - 3:00 PM",
      "location": "Panchayat Office",
      "category": "General",
      "status": "Completed",
      "description":
      "General health checkup including BP, sugar and consultation.",
    },
    {
      "title": "Dental Camp",
      "date": "4 March 2026",
      "time": "10:30 AM - 1:30 PM",
      "location": "Community Center",
      "category": "Dental",
      "status": "Ongoing",
      "description":
      "Free dental checkup and cavity treatment consultation.",
    },
  ];

  @override
  Widget build(BuildContext context) {

    List<Map<String, dynamic>> filteredCamps =
    camps.where((camp) {

      final matchesFilter =
          selectedFilter == "All" ||
              camp["status"] == selectedFilter;

      final matchesSearch = camp["title"]
          .toLowerCase()
          .contains(searchQuery.toLowerCase());

      return matchesFilter && matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF2F5F9),
      appBar: AppBar(
        title: const Text("Health Camps"),
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
                hintText: "Search health camps...",
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

          /// FILTER CHIPS
          SizedBox(
            height: 45,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              children: [
                filterChip("All"),
                filterChip("Upcoming"),
                filterChip("Ongoing"),
                filterChip("Completed"),
              ],
            ),
          ),

          const SizedBox(height: 10),

          /// CAMP LIST
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: filteredCamps.length,
              itemBuilder: (context, index) {
                final camp = filteredCamps[index];
                return HealthCard(
                  title: camp["title"],
                  date: camp["date"],
                  time: camp["time"],
                  location: camp["location"],
                  category: camp["category"],
                  status: camp["status"],
                  description: camp["description"],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget filterChip(String label) {
    final bool isSelected = selectedFilter == label;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        selectedColor: const Color(0xFF1B5E20),
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
        ),
        onSelected: (_) {
          setState(() {
            selectedFilter = label;
          });
        },
      ),
    );
  }
}

class HealthCard extends StatefulWidget {
  final String title;
  final String date;
  final String time;
  final String location;
  final String category;
  final String status;
  final String description;

  const HealthCard({
    super.key,
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.category,
    required this.status,
    required this.description,
  });

  @override
  State<HealthCard> createState() => _HealthCardState();
}

class _HealthCardState extends State<HealthCard> {

  bool expanded = false;

  Color getStatusColor(String status) {
    switch (status) {
      case "Upcoming":
        return Colors.blue;
      case "Ongoing":
        return Colors.green;
      case "Completed":
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {

    final statusColor = getStatusColor(widget.status);

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(18),
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
                padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  widget.status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          /// CATEGORY CHIP
          Container(
            padding:
            const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF1B5E20).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              widget.category,
              style: const TextStyle(
                color: Color(0xFF1B5E20),
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(height: 10),

          /// LOCATION + TIME
          Row(
            children: [
              const Icon(Icons.location_on,
                  size: 16, color: Colors.grey),
              const SizedBox(width: 5),
              Expanded(
                child: Text(widget.location,
                    style: const TextStyle(
                        fontSize: 13, color: Colors.grey)),
              ),
            ],
          ),

          const SizedBox(height: 5),

          Row(
            children: [
              const Icon(Icons.access_time,
                  size: 16, color: Colors.grey),
              const SizedBox(width: 5),
              Text(widget.time,
                  style: const TextStyle(
                      fontSize: 13, color: Colors.grey)),
            ],
          ),

          const SizedBox(height: 10),

          /// DESCRIPTION
          Text(
            expanded
                ? widget.description
                : widget.description.length > 80
                ? widget.description.substring(0, 80) + "..."
                : widget.description,
            style: const TextStyle(fontSize: 13),
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
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

          const SizedBox(height: 8),

          Text(
            widget.date,
            style: const TextStyle(
                fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}