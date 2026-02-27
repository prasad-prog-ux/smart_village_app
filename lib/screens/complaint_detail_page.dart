import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ComplaintsTab extends StatefulWidget {
  const ComplaintsTab({super.key});

  @override
  State<ComplaintsTab> createState() => _ComplaintsTabState();
}

class _ComplaintsTabState extends State<ComplaintsTab> {

  List<Map<String, dynamic>> complaints = [];

  final List<String> categories = [
    "Infrastructure",
    "Water",
    "Electricity",
    "Sanitation",
    "Other"
  ];

  @override
  void initState() {
    super.initState();
    _loadComplaints();
  }

  Future<void> _loadComplaints() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString("complaints");

    if (data != null) {
      setState(() {
        complaints =
        List<Map<String, dynamic>>.from(jsonDecode(data));
      });
    } else {
      complaints = [
        {
          "title": "Street Light Not Working",
          "category": "Infrastructure",
          "description":
          "The street light near the bus stop is not functioning.",
          "status": "Pending",
          "date": "21 Oct 2025"
        },
      ];
      _saveComplaints();
      setState(() {});
    }
  }

  Future<void> _saveComplaints() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("complaints", jsonEncode(complaints));
  }

  void _addComplaint(
      String title, String category, String description) {
    setState(() {
      complaints.add({
        "title": title,
        "category": category,
        "description": description,
        "status": "Pending",
        "date": DateTime.now().toString().substring(0, 10),
      });
    });
    _saveComplaints();
  }

  Color _statusColor(String status) {
    switch (status) {
      case "Resolved":
        return Colors.green;
      case "Pending":
        return Colors.orange;
      default:
        return Colors.blue;
    }
  }

  int _statusIndex(String s) {
    if (s == "Pending") return 0;
    if (s == "In Progress") return 1;
    return 2;
  }

  void _openComplaintDetails(int index) {
    final complaint = complaints[index];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius:
        BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            String status = complaint["status"];
            int currentStep = _statusIndex(status);

            void updateStatus(String newStatus) {
              setState(() {
                complaints[index]["status"] = newStatus;
              });
              _saveComplaints();
              setModalState(() {
                status = newStatus;
                currentStep = _statusIndex(newStatus);
              });
            }

            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  Text(
                    complaint["title"],
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  Text(complaint["description"]),

                  const SizedBox(height: 20),

                  /// TIMELINE
                  Stepper(
                    currentStep: currentStep,
                    controlsBuilder:
                        (context, details) =>
                    const SizedBox(),
                    steps: const [
                      Step(
                        title: Text("Submitted"),
                        content:
                        Text("Complaint Registered"),
                        isActive: true,
                      ),
                      Step(
                        title: Text("In Progress"),
                        content:
                        Text("Under Review"),
                        isActive: true,
                      ),
                      Step(
                        title: Text("Resolved"),
                        content: Text("Issue Fixed"),
                        isActive: true,
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      if (status == "Pending")
                        ElevatedButton(
                          onPressed: () =>
                              updateStatus("In Progress"),
                          style:
                          ElevatedButton.styleFrom(
                            backgroundColor:
                            const Color(
                                0xFF1B5E20),
                          ),
                          child:
                          const Text("Start Work"),
                        ),

                      const SizedBox(width: 10),

                      if (status != "Resolved")
                        ElevatedButton(
                          onPressed: () =>
                              updateStatus("Resolved"),
                          style:
                          ElevatedButton.styleFrom(
                            backgroundColor:
                            Colors.green,
                          ),
                          child:
                          const Text("Mark Resolved"),
                        ),
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _openAddComplaint() {
    String title = "";
    String description = "";
    String selectedCategory = categories.first;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius:
        BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context)
                  .viewInsets
                  .bottom),
          child: StatefulBuilder(
            builder: (context, setModalState) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    const Text(
                      "Register Complaint",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 20),

                    TextField(
                      decoration:
                      const InputDecoration(
                        labelText: "Issue Title",
                        border:
                        OutlineInputBorder(),
                      ),
                      onChanged: (val) =>
                      title = val,
                    ),

                    const SizedBox(height: 15),

                    TextField(
                      maxLines: 3,
                      decoration:
                      const InputDecoration(
                        labelText:
                        "Short Description",
                        border:
                        OutlineInputBorder(),
                      ),
                      onChanged: (val) =>
                      description = val,
                    ),

                    const SizedBox(height: 15),

                    DropdownButtonFormField(
                      value: selectedCategory,
                      items: categories
                          .map((e) =>
                          DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                          .toList(),
                      decoration:
                      const InputDecoration(
                        labelText: "Category",
                        border:
                        OutlineInputBorder(),
                      ),
                      onChanged: (val) {
                        setModalState(() {
                          selectedCategory =
                          val!;
                        });
                      },
                    ),

                    const SizedBox(height: 20),

                    ElevatedButton(
                      style:
                      ElevatedButton.styleFrom(
                        backgroundColor:
                        const Color(
                            0xFF1B5E20),
                        minimumSize:
                        const Size(
                            double.infinity,
                            45),
                      ),
                      onPressed: () {
                        if (title.isNotEmpty &&
                            description
                                .isNotEmpty) {
                          _addComplaint(
                              title,
                              selectedCategory,
                              description);
                          Navigator.pop(context);
                        }
                      },
                      child:
                      const Text("Submit"),
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F5F9),

      floatingActionButton:
      FloatingActionButton(
        backgroundColor:
        const Color(0xFF1B5E20),
        onPressed: _openAddComplaint,
        child: SvgPicture.asset(
          "assets/icons/plus.svg",
          height: 20,
          colorFilter:
          const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn),
        ),
      ),

      body: Column(
        children: [

          /// HEADER
          Container(
            width: double.infinity,
            padding:
            const EdgeInsets.fromLTRB(
                20, 60, 20, 25),
            decoration:
            const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF1B5E20),
                  Color(0xFF2E7D32)
                ],
              ),
              borderRadius:
              BorderRadius.only(
                bottomLeft:
                Radius.circular(30),
                bottomRight:
                Radius.circular(30),
              ),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  "assets/icons/document-text.svg",
                  height: 24,
                  colorFilter:
                  const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn),
                ),
                const SizedBox(width: 10),
                const Text(
                  "Complaints",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight:
                      FontWeight.bold),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          /// LIST
          Expanded(
            child: ListView.builder(
              padding:
              const EdgeInsets
                  .symmetric(
                  horizontal: 20),
              itemCount:
              complaints.length,
              itemBuilder:
                  (_, index) {
                final complaint =
                complaints[index];
                final statusColor =
                _statusColor(
                    complaint["status"]);

                return InkWell(
                  onTap: () =>
                      _openComplaintDetails(
                          index),
                  child: Container(
                    margin:
                    const EdgeInsets
                        .only(
                        bottom: 15),
                    padding:
                    const EdgeInsets
                        .all(18),
                    decoration:
                    BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      BorderRadius
                          .circular(
                          22),
                      boxShadow: [
                        BoxShadow(
                          color: Colors
                              .green
                              .withAlpha(
                              15),
                          blurRadius:
                          8,
                          offset:
                          const Offset(
                              0, 4),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                      children: [

                        Text(
                          complaint[
                          "title"],
                          style:
                          const TextStyle(
                              fontWeight:
                              FontWeight
                                  .w600),
                        ),

                        const SizedBox(
                            height: 5),

                        Text(
                          complaint[
                          "category"],
                          style:
                          const TextStyle(
                              fontSize:
                              12,
                              color: Colors
                                  .grey),
                        ),

                        const SizedBox(
                            height: 12),

                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,
                          children: [

                            Container(
                              padding:
                              const EdgeInsets
                                  .symmetric(
                                  horizontal:
                                  10,
                                  vertical:
                                  5),
                              decoration:
                              BoxDecoration(
                                color:
                                statusColor
                                    .withAlpha(
                                    30),
                                borderRadius:
                                BorderRadius
                                    .circular(
                                    20),
                              ),
                              child: Text(
                                complaint[
                                "status"],
                                style: TextStyle(
                                    color:
                                    statusColor,
                                    fontSize:
                                    12,
                                    fontWeight:
                                    FontWeight
                                        .w600),
                              ),
                            ),

                            Text(
                              complaint[
                              "date"],
                              style:
                              const TextStyle(
                                fontSize:
                                11,
                                color: Colors
                                    .grey,
                              ),
                            )
                          ],
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
}