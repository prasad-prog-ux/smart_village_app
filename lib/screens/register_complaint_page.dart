import 'package:flutter/material.dart';
import 'package:smart_village_app/widgets/village_header.dart';
import 'package:smart_village_app/widgets/bottom_nav_bar.dart';
import 'package:smart_village_app/data/complaint_list.dart';

class RegisterComplaintPage extends StatefulWidget {
  const RegisterComplaintPage({super.key});

  @override
  State<RegisterComplaintPage> createState() =>
      _RegisterComplaintPageState();
}

class _RegisterComplaintPageState
    extends State<RegisterComplaintPage> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController =
  TextEditingController();
  final TextEditingController _descriptionController =
  TextEditingController();
  final TextEditingController _locationController =
  TextEditingController();

  String _selectedCategory = "Water Supply";

  final List<String> categories = [
    "Water Supply",
    "Street Light",
    "Road Damage",
    "Garbage Collection",
    "Drainage",
    "Electricity",
    "Other"
  ];

  void _submitComplaint() {
    if (_formKey.currentState!.validate()) {

      complaints.add(
        Complaint(
          id: (complaints.length + 1).toString(),
          title: _titleController.text,
          description: _descriptionController.text,
          category: _selectedCategory,
          status: "Pending",
          date: DateTime.now().toString().split(" ")[0],
          location: _locationController.text,
          department: "Gram Panchayat",
          phone: "9876543210",
          email: "support@village.in",
          statusColor: Colors.orange,
          statusColor2: Colors.orange.shade50,
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Complaint Submitted Successfully"),
        ),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),

      body: Column(
        children: [

          const VillageHeader(
            title: "Gram Setu",
            subtitle: "Green Valley",
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [

                    const Text(
                      "Register Complaint",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    _buildTextField(
                      controller: _titleController,
                      label: "Title",
                    ),

                    const SizedBox(height: 16),

                    _buildTextField(
                      controller: _descriptionController,
                      label: "Description",
                      maxLines: 4,
                    ),

                    const SizedBox(height: 16),

                    const Text(
                      "Category",
                      style: TextStyle(
                          fontWeight: FontWeight.w600),
                    ),

                    const SizedBox(height: 8),

                    DropdownButtonFormField<String>(
                      value: _selectedCategory,
                      items: categories
                          .map(
                            (category) =>
                            DropdownMenuItem(
                              value: category,
                              child: Text(category),
                            ),
                      )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory =
                          value!;
                        });
                      },
                      decoration: _inputDecoration(),
                    ),

                    const SizedBox(height: 16),

                    _buildTextField(
                      controller: _locationController,
                      label: "Location / Ward",
                    ),

                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                          const Color(0xFF1B5E20),
                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(
                                14),
                          ),
                        ),
                        onPressed: _submitComplaint,
                        child: const Text(
                          "Submit Complaint",
                          style: TextStyle(
                            fontWeight:
                            FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar:
      const AppBottomNav(currentIndex: 1),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: (value) =>
      value!.isEmpty ? "Required Field" : null,
      decoration: _inputDecoration(label),
    );
  }

  InputDecoration _inputDecoration(
      [String? label]) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius:
        BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      contentPadding:
      const EdgeInsets.symmetric(
          horizontal: 16, vertical: 14),
    );
  }
}