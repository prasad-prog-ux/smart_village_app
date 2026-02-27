import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/village_header.dart';
import 'package:smart_village_app/data/complaint_list.dart';
import 'complaint_detail_page.dart';
import 'register_complaint_page.dart';

class ComplaintsPage extends StatefulWidget {
  const ComplaintsPage({super.key});

  @override
  State<ComplaintsPage> createState() => _ComplaintsPageState();
}

class _ComplaintsPageState extends State<ComplaintsPage> {

  Future<void> _openRegisterPage() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const RegisterComplaintPage(),
      ),
    );

    setState(() {}); // 🔥 refresh after coming back
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

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 18, 16, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const Text(
                  "Complaints",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 18),

                // 🔥 Register Button
                InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: _openRegisterPage,
                  child: Container(
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: const Color(0xFF1B5E20),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add, color: Colors.white),
                        SizedBox(width: 10),
                        Text(
                          "Register New Complaint",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: complaints.isEmpty
                ? const Center(
              child: Text(
                "No complaints yet",
                style: TextStyle(color: Colors.grey),
              ),
            )
                : ListView.builder(
              padding:
              const EdgeInsets.symmetric(horizontal: 16),
              itemCount: complaints.length,
              itemBuilder: (context, index) {
                final complaint = complaints[index];
                return _ComplaintCard(
                  complaint: complaint,
                );
              },
            ),
          ),
        ],
      ),

      bottomNavigationBar:
      const AppBottomNav(currentIndex: 1),

      // 🔥 Floating Action Button
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF1B5E20),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: _openRegisterPage,
      ),
    );
  }
}

class _ComplaintCard extends StatelessWidget {
  final Complaint complaint;

  const _ComplaintCard({
    required this.complaint,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [

          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: complaint.statusColor
                      .withOpacity(0.1),
                  borderRadius:
                  BorderRadius.circular(20),
                ),
                child: Text(
                  complaint.status,
                  style: TextStyle(
                    color: complaint.statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const Spacer(),

              Text(
                "ID: ${complaint.id}",
                style: const TextStyle(
                    fontSize: 11,
                    color: Colors.grey),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Text(
            complaint.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            complaint.description,
            style: const TextStyle(
                color: Colors.grey),
          ),

          const SizedBox(height: 12),

          Text(
            "${complaint.category} • ${complaint.location}",
            style: const TextStyle(
                fontSize: 12,
                color: Colors.grey),
          ),

          const SizedBox(height: 10),

          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      ComplaintDetailPage(
                          complaint: complaint),
                ),
              );
            },
            child: const Text(
              "Track Status",
              style: TextStyle(
                  color: Color(0xFF1B5E20)),
            ),
          ),
        ],
      ),
    );
  }
}