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
  Set<String> bookmarkedSchemes = {};
  Set<int> expandedIndex = {};

  final List<Map<String, String>> schemes = [

    {
      "title": "PM Kisan Samman Nidhi",
      "category": "Agriculture",
      "description": "Direct income support of ₹6000 per year to eligible farmers.",
      "eligibility": "Small & marginal landholding farmers",
      "url": "https://pmkisan.gov.in/",
      "icon": "agriculture.svg",
      "documents": "Aadhaar Card, Land Ownership Documents, Bank Passbook",
      "mode": "Online Portal & CSC Centers",
      "contact": "PM Kisan Helpline: 155261"
    },

    {
      "title": "Ayushman Bharat Yojana",
      "category": "Health",
      "description": "Health insurance coverage up to ₹5 lakh per family annually.",
      "eligibility": "Eligible families listed in SECC database",
      "url": "https://pmjay.gov.in/",
      "icon": "heart.svg",
      "documents": "Aadhaar Card, Ration Card, Registered Mobile Number",
      "mode": "Hospital Enrollment & Online Portal",
      "contact": "Ayushman Helpline: 14555"
    },

    {
      "title": "PM Scholarship Scheme",
      "category": "Education",
      "description": "Financial support for students pursuing higher education.",
      "eligibility": "Students meeting income and academic criteria",
      "url": "https://www.aicte-india.org/",
      "icon": "academic-cap.svg",
      "documents": "Income Certificate, Previous Academic Marksheet, Aadhaar Card",
      "mode": "Online Application Only",
      "contact": "AICTE Support: 011-29581000"
    },

    {
      "title": "Beti Bachao Beti Padhao",
      "category": "Women",
      "description": "Scheme promoting education and welfare of the girl child.",
      "eligibility": "Girl child & eligible families",
      "url": "https://wcd.nic.in/",
      "icon": "user-group.svg",
      "documents": "Birth Certificate of Child, Aadhaar of Parents",
      "mode": "Through District Welfare Office",
      "contact": "Women Helpline: 181"
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Government Schemes",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    final savedList = schemes
                        .where((scheme) =>
                        bookmarkedSchemes.contains(scheme["title"]))
                        .toList();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SavedSchemesScreen(
                          savedSchemes: savedList,
                        ),
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.bookmark,
                    color: Colors.white,
                  ),
                )
              ],
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

                return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    margin: const EdgeInsets.only(bottom: 15),
                    child: Container(
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
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (bookmarkedSchemes.contains(scheme["title"])) {
                                  bookmarkedSchemes.remove(scheme["title"]);
                                } else {
                                  bookmarkedSchemes.add(scheme["title"]!);
                                }
                              });
                            },
                            child: Icon(
                              bookmarkedSchemes.contains(scheme["title"])
                                  ? Icons.bookmark
                                  : Icons.bookmark_border,
                              color: const Color(0xFF1B5E20),
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
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (expandedIndex.contains(index)) {
                              expandedIndex.remove(index);
                            } else {
                              expandedIndex.add(index);
                            }
                          });
                        },
                        child: Row(
                          children: [
                            const Text(
                              "View Details",
                              style: TextStyle(
                                color: Color(0xFF1B5E20),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Icon(
                              expandedIndex.contains(index)
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              color: const Color(0xFF1B5E20),
                            )
                          ],
                        ),
                      ),

                      if (expandedIndex.contains(index))
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("• Required Documents: ${scheme["documents"]}"),
                              const SizedBox(height: 4),
                              Text("• Application Mode: ${scheme["mode"]}"),
                              const SizedBox(height: 4),
                              Text("• Contact: ${scheme["contact"]}"),
                            ],
                          ),
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
                          backgroundColor: const Color(0xFF00C853),
                          elevation: 4, // shadow effect
                          shadowColor: Colors.black26,
                          minimumSize: const Size(double.infinity, 45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () => openUrl(scheme["url"]!),
                        icon: SvgPicture.asset(
                          "assets/icons/arrow-top-right-on-square.svg",
                          height: 16,
                          colorFilter: const ColorFilter.mode(
                              Colors.white, BlendMode.srcIn),
                        ),
                        label: const Text("Apply Now"
                        ,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          letterSpacing: 0.5,
                        ),),
                      )
                    ],
                  ),
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
class SavedSchemesScreen extends StatelessWidget {
  final List<Map<String, String>> savedSchemes;

  const SavedSchemesScreen({super.key, required this.savedSchemes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B5E20),
        title: const Text("Saved Schemes"),
      ),
      body: savedSchemes.isEmpty
          ? const Center(
        child: Text("No saved schemes yet."),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: savedSchemes.length,
        itemBuilder: (_, index) {
          final scheme = savedSchemes[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 15),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    scheme["title"]!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(scheme["description"]!),
                  const SizedBox(height: 8),
                  Text("Eligibility: ${scheme["eligibility"]}"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}