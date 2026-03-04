import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatTab extends StatelessWidget {
  const ChatTab({super.key});

  @override
  Widget build(BuildContext context) {
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
              children: [
                SvgPicture.asset(
                  "assets/icons/chat-bubble-left-right.svg",
                  height: 26,
                  colorFilter: const ColorFilter.mode(
                      Colors.white, BlendMode.srcIn),
                ),
                const SizedBox(width: 10),
                const Text(
                  "Community Chat",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: const [

                _ChatCard(title: "Farmers Group", members: "124 members"),
                SizedBox(height: 15),

                _ChatCard(title: "Youth Network", members: "89 members"),
                SizedBox(height: 15),

                _ChatCard(title: "Health Updates", members: "256 members"),
                SizedBox(height: 15),

                _ChatCard(title: "Village AI Assistant", members: "Smart  ChatBot 🤖", isAI: true),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatCard extends StatelessWidget {
  final String title;
  final String members;
  final bool isAI;

  const _ChatCard({
    required this.title,
    required this.members,
    this.isAI = false,
  });
  String getGroupIcon(String title, bool isAI) {
    if (isAI) {
      return "assets/icons/sparkles.svg";
    } else if (title == "Farmer Group") {
      return "assets/icons/tractor.svg";
    } else if (title == "Youth Network") {
      return "assets/icons/trophy.svg";
    } else if (title == "Health Updates") {
      return "assets/icons/cross.svg";
    } else {
      return "assets/icons/diversity.svg";
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ChatDetailScreen(
            groupName: title,
            isAI: isAI,
          ),
        ),
      ),
      child: Container(
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
        child: Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: const Color(0xFFE8F5E9),
              child: SvgPicture.asset(
                getGroupIcon(title, isAI),
                height: 22,
                colorFilter: const ColorFilter.mode(
                    Color(0xFF1B5E20), BlendMode.srcIn),
              ),
            ),
            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15)),
                  const SizedBox(height: 4),
                  Text(members,
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ================= CHAT DETAIL =================

class ChatDetailScreen extends StatefulWidget {
  final String groupName;
  final bool isAI;

  const ChatDetailScreen({
    super.key,
    required this.groupName,
    this.isAI = false,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  bool isTyping = false;
  String lastTopic = "";
  List<String> conversationLog = [];

  final List<Map<String, dynamic>> messages = [];
  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    if (widget.groupName == "Farmers Group") {
      messages.addAll([
        {
          "text": "📢 Notice: Fertilizer distribution will begin tomorrow at 9:00 AM at the Agriculture Center.",
          "isMe": false,
          "isAdmin": true
        },
        {
          "text": "Please carry your ID proof while collecting supplies.",
          "isMe": false,
          "isAdmin": false
        },
      ]);
    }

    if (widget.groupName == "Youth Network") {
      messages.addAll([
        {
          "text": "⚽ Football tournament scheduled this Sunday at 5 PM.",
          "isMe": false,
          "isAdmin": true
        },
        {
          "text": "All participants must register before Saturday evening.",
          "isMe": false,
          "isAdmin": false
        },
      ]);
    }

    if (widget.groupName == "Health Updates") {
      messages.addAll([
        {
          "text": "🏥 Free health check-up camp on Friday at Community Hall.",
          "isMe": false,
          "isAdmin": true
        },
        {
          "text": "Vaccination and general consultation will be available.",
          "isMe": false,
          "isAdmin": false
        },
      ]);
    }

    if (widget.isAI) {
      messages.add({
        "text": "Hello 👋 I am your Village AI Assistant.\n\nYou can ask me about:\n• Water Supply\n• Electricity\n• Roads\n• Health Camps\n• Farming Updates",
        "isMe": false,
        "isAdmin": true
      });
    }
  }


  String aiReply(String text) {
    text = text.toLowerCase().trim();
    conversationLog.add(text);

    // ===== GREETING =====
    if (text.contains("hello") ||
        text.contains("hi") ||
        text.contains("hey")) {
      return "Hello 👋\n\nI’m your Village AI Assistant. I can help you with water supply, electricity, road maintenance, health services, and farming support.\n\nHow may I assist you today?";
    }

    // ===== SUMMARY MODE =====
    if (text.contains("summary") || text.contains("summarize")) {
      return "📋 Conversation Summary:\n\n• Topic discussed: $lastTopic\n• Messages exchanged: ${conversationLog.length}\n\nIf your issue is still unresolved, I recommend submitting a complaint in the Complaint section of the app for proper tracking.";
    }

    // ===== WATER =====
    if (text.contains("water") || text.contains("pani")) {
      lastTopic = "Water Supply";

      return "💧 Water Supply Information:\n\nThe regular timing is 7:00 AM to 9:00 AM daily.\n\nAre you experiencing low pressure, irregular timing, or no water at all?";
    }

    if (lastTopic == "Water Supply" &&
        (text.contains("no water") || text.contains("not coming"))) {
      return "I understand how inconvenient it is to have no water supply.\n\nIf the issue has continued for several hours, I recommend registering a complaint in the Complaint section so it can be tracked properly.";
    }

    if (lastTopic == "Water Supply" &&
        text.contains("low")) {
      return "Low water pressure is usually caused by pipeline leakage or peak hour consumption.\n\nIf this is happening frequently, submitting a complaint will help the maintenance team investigate.";
    }

    // ===== ELECTRICITY =====
    if (text.contains("electricity") ||
        text.contains("power") ||
        text.contains("light")) {
      lastTopic = "Electricity";

      return "⚡ Electricity Information:\n\nScheduled maintenance is on Sunday at 2 PM.\n\nAre you facing a complete power cut, voltage fluctuation, or frequent interruptions?";
    }

    if (lastTopic == "Electricity" &&
        (text.contains("no power") || text.contains("power cut"))) {
      return "A prolonged power outage may indicate transformer or line issues.\n\nIf it has been more than 2 hours, I suggest registering a complaint in the Complaint tab so the issue can be escalated.\n\nHow long has the outage lasted?";
    }

    if (lastTopic == "Electricity" &&
        text.contains("voltage")) {
      return "Voltage fluctuation can damage appliances.\n\nPlease avoid using heavy devices temporarily.\n\nIf the issue continues, submitting a complaint would be advisable.";
    }

    // ===== HEALTH =====
    if (text.contains("health") ||
        text.contains("doctor") ||
        text.contains("hospital") ||
        text.contains("camp")) {
      lastTopic = "Health Services";

      return "🏥 Health Services Update:\n\nA free health camp is scheduled this Friday at 10 AM in the Community Hall.\n\nAre you looking for general consultation or a specific treatment?";
    }

    if (lastTopic == "Health Services" &&
        text.contains("doctor not")) {
      return "If the doctor is unavailable, it might be due to field duty or emergency assignments.\n\nYou may visit during the next scheduled camp or register a complaint for follow-up.\n\nWould you like more details?";
    }

    // ===== ROAD =====
    if (text.contains("road") ||
        text.contains("pothole") ||
        text.contains("repair")) {
      lastTopic = "Road Maintenance";

      return "🛣 Road Maintenance Update:\n\nRepair work near the main market area is planned for next week.\n\nIf you are reporting a pothole or safety hazard, I recommend registering a complaint with the exact location.\n\nWould you like to proceed?";
    }

    // ===== FARMING =====
    if (text.contains("fertilizer") ||
        text.contains("crop") ||
        text.contains("farm")) {
      lastTopic = "Farming Support";

      return "🌾 Farming Support Information:\n\nFertilizer distribution begins tomorrow at 9 AM at the Agriculture Center.\n\nAre you asking about availability, crop advice, or pricing details?";
    }

    // ===== EMERGENCY DETECTION =====
    if (text.contains("spark") ||
        text.contains("fire") ||
        text.contains("danger")) {
      return "⚠️ This appears to be a potential safety hazard.\n\nPlease stay away from the affected area immediately.\n\nI strongly recommend registering an urgent complaint in the Complaint section for immediate attention.";
    }

    // ===== THANK YOU =====
    if (text.contains("thank")) {
      return "You're welcome 😊\n\nIf you need any further assistance regarding village services, feel free to ask anytime.";
    }

    // ===== DEFAULT SMART RESPONSE =====
    return "Thank you for your message.\n\nTo assist you accurately, could you please provide more specific details about your concern?";
  }
  void sendMessage() {
    if (controller.text.trim().isEmpty) return;

    String userMessage = controller.text.trim();

    setState(() {
      messages.add({
        "text": userMessage,
        "isMe": true,
        "isAdmin": false
      });
    });

    controller.clear();

    if (widget.isAI) {

      setState(() {
        isTyping = true;
      });

      Future.delayed(const Duration(seconds: 1), () {

        setState(() {
          isTyping = false;
          messages.add({
            "text": aiReply(userMessage),
            "isMe": false,
            "isAdmin": true
          });
        });

        if (scrollController.hasClients) {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }

      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F5F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B5E20),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.groupName),
            if (widget.isAI)
              const Text(
                "Online",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.greenAccent,
                ),
              ),
          ],
        ),
      ),
      body: Column(
        children: [

          Expanded(
            child: ListView.builder(
              controller: scrollController,
              padding: const EdgeInsets.all(15),
              itemCount: messages.length + (isTyping ? 1 : 0),
              itemBuilder: (_, index) {
                if (index >= messages.length) {
                  return const Padding(
                    padding: EdgeInsets.only(left: 10, bottom: 10),
                    child: Text(
                      "AI is typing...",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.grey,
                      ),
                    ),
                  );
                }
                final msg = messages[index];

                return Align(
                  alignment: msg["isMe"]
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: msg["isMe"]
                          ? const Color(0xFF1B5E20)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withAlpha(20),
                          blurRadius: 5,
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        if (msg["isAdmin"] == true)
                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/icons/shield-check.svg",
                                height: 14,
                                colorFilter: const ColorFilter.mode(
                                    Color(0xFF1B5E20), BlendMode.srcIn),
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                "Admin",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1B5E20),
                                ),
                              ),
                            ],
                          ),

                        Text(
                          msg["text"],
                          style: TextStyle(
                            color: msg["isMe"]
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: "Type a message...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                InkWell(
                  onTap: sendMessage,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: Color(0xFF1B5E20),
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/send.svg",
                      height: 18,
                      colorFilter: const ColorFilter.mode(
                          Colors.white, BlendMode.srcIn),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}