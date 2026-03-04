import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DirectoryScreen extends StatefulWidget {
  const DirectoryScreen({super.key});

  @override
  State<DirectoryScreen> createState() => _DirectoryScreenState();
}

class _DirectoryScreenState extends State<DirectoryScreen> {

  String selectedCategory = "All";
  String searchQuery = "";

  final List<Map<String, String>> contacts = [
    {"name": "Police Station", "number": "100", "category": "Emergency", "icon": "assets/icons/police.svg"},
    {"name": "Fire Brigade", "number": "101", "category": "Emergency", "icon": "assets/icons/fire.svg"},
    {"name": "Ambulance", "number": "102", "category": "Emergency", "icon": "assets/icons/hospital.svg"},
    {"name": "Gram Panchayat Office", "number": "9876543210", "category": "Offices", "icon": "assets/icons/office.svg"},
    {"name": "Sarpanch - Rajesh Patil", "number": "9876500001", "category": "Offices", "icon": "assets/icons/office.svg"},
    {"name": "Talathi Office", "number": "9876500002", "category": "Offices", "icon": "assets/icons/office.svg"},
    {"name": "Primary Health Center", "number": "9876500003", "category": "Health", "icon": "assets/icons/health.svg"},
    {"name": "Village Doctor", "number": "9876500004", "category": "Health", "icon": "assets/icons/health.svg"},
    {"name": "Veterinary Clinic", "number": "9876500005", "category": "Health", "icon": "assets/icons/health.svg"},
    {"name": "Water Supply Officer", "number": "9876500006", "category": "Utilities", "icon": "assets/icons/water.svg"},
    {"name": "Electricity Board Office", "number": "9876500007", "category": "Utilities", "icon": "assets/icons/utilities.svg"},
  ];

  @override
  Widget build(BuildContext context) {

    List<Map<String, String>> filteredContacts = contacts.where((contact) {
      final matchesCategory =
          selectedCategory == "All" || contact["category"] == selectedCategory;

      final matchesSearch =
      contact["name"]!.toLowerCase().contains(searchQuery.toLowerCase());

      return matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF2F5F9),
      appBar: AppBar(
        title: const Text("Village Directory"),
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
                hintText: "Search contact...",
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
              padding: const EdgeInsets.symmetric(horizontal: 10),
              children: [
                categoryChip("All"),
                categoryChip("Emergency"),
                categoryChip("Offices"),
                categoryChip("Health"),
                categoryChip("Utilities"),
              ],
            ),
          ),

          const SizedBox(height: 10),

          /// CONTACT LIST
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: filteredContacts.length,
              itemBuilder: (context, index) {
                final contact = filteredContacts[index];
                return contactCard(
                  contact["name"]!,
                  contact["number"]!,
                  contact["category"]!,
                  contact["icon"]!,
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

  Widget contactCard(String name, String number, String category, String icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
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
              color: const Color(0xFF1B5E20).withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: SvgPicture.asset(
              icon,
              height: 26,
              colorFilter: const ColorFilter.mode(
                Color(0xFF1B5E20),
                BlendMode.srcIn,
              ),
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15)),
                const SizedBox(height: 4),
                Text(number,
                    style: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey)),
                const SizedBox(height: 4),
                Text(category,
                    style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF1B5E20))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}