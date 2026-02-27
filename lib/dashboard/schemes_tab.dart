import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class SchemesTab extends StatefulWidget {
  const SchemesTab({super.key});

  @override
  State<SchemesTab> createState() => _SchemesTabState();
}

class _SchemesTabState extends State<SchemesTab> {

  String selectedCategory = "All";
  String searchQuery = "";

  final List<Map<String, String>> schemes = [

    {
      "title": "PM Kisan Samman Nidhi",
      "category": "Agriculture",
      "description": "Financial support for farmers.",
      "eligibility": "Small & marginal farmers",
      "url": "https://pmkisan.gov.in/",
      "icon": "leaf.svg"
    },

    {
      "title": "Ayushman Bharat Yojana",
      "category": "Health",
      "description": "Free health insurance up to ₹5 lakh.",
      "eligibility": "Eligible low-income families",
      "url": "https://pmjay.gov.in/",
      "icon": "heart.svg"
    },

    {
      "title": "PM Scholarship Scheme",
      "category": "Education",
      "description": "Scholarship for higher studies.",
      "eligibility": "Students meeting income criteria",
      "url": "https://www.aicte-india.org/schemes/students-development-schemes/PMSSS",
      "icon": "academic-cap.svg"
    },

    {
      "title": "Beti Bachao Beti Padhao",
      "category": "Women",
      "description": "Support & empowerment for girls.",
      "eligibility": "Girl child welfare programs",
      "url": "https://wcd.nic.in/bbbp-schemes",
      "icon": "user-group.svg"
    },
  ];

  Future<void> openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {

    final filteredSchemes = schemes.where((scheme) {
      final matchesCategory =
          selectedCategory == "All" || scheme["category"] == selectedCategory;

      final matchesSearch =
      scheme["title"]!.toLowerCase().contains(searchQuery.toLowerCase());

      return matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF2F5F9),
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
              "Government Schemes",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 20),

          /// SEARCH
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search schemes...",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12),
                  child: SvgPicture.asset(
                    "assets/icons/magnifying-glass.svg",
                    height: 18,
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),

          const SizedBox(height: 15),

          /// CATEGORY FILTER
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                _buildFilter("All"),
                _buildFilter("Education"),
                _buildFilter("Agriculture"),
                _buildFilter("Health"),
                _buildFilter("Women"),
              ],
            ),
          ),

          const SizedBox(height: 15),

          /// SCHEME LIST
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: filteredSchemes.length,
              itemBuilder: (_, index) {

                final scheme = filteredSchemes[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withAlpha(15),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/${scheme["icon"]}",
                            height: 22,
                            colorFilter: const ColorFilter.mode(
                                Color(0xFF1B5E20), BlendMode.srcIn),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              scheme["title"]!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                            ),
                          )
                        ],
                      ),

                      const SizedBox(height: 8),

                      Text(
                        scheme["description"]!,
                        style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black87),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        "Eligibility: ${scheme["eligibility"]}",
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey),
                      ),

                      const SizedBox(height: 12),

                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1B5E20),
                          minimumSize: const Size(double.infinity, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        onPressed: () => openUrl(scheme["url"]!),
                        icon: SvgPicture.asset(
                          "assets/icons/arrow-top-right-on-square.svg",
                          height: 16,
                          colorFilter: const ColorFilter.mode(
                              Colors.white, BlendMode.srcIn),
                        ),
                        label: const Text("Apply Now"),
                      )
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFilter(String category) {
    final isSelected = selectedCategory == category;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = category;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1B5E20) : Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        child: Text(
          category,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}