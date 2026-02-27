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
              child: isAI
                  ? SvgPicture.asset(
                "assets/icons/sparkles.svg",
                height: 20,
                colorFilter: const ColorFilter.mode(
                    Color(0xFF1B5E20), BlendMode.srcIn),
              )
                  : SvgPicture.asset(
                "assets/icons/users.svg",
                height: 20,
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

  final List<Map<String, dynamic>> messages = [];
  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    if (widget.groupName == "Farmers Group") {
      messages.addAll([
        {"text": "Fertilizer distribution starts tomorrow.", "isMe": false, "isAdmin": true},
        {"text": "Anyone facing irrigation issues?", "isMe": false, "isAdmin": false},
      ]);
    }

    if (widget.groupName == "Youth Network") {
      messages.addAll([
        {"text": "Football match this Sunday ⚽", "isMe": false, "isAdmin": true},
        {"text": "Practice at 4 PM today!", "isMe": false, "isAdmin": false},
      ]);
    }

    if (widget.groupName == "Health Updates") {
      messages.addAll([
        {"text": "Vaccination camp on Friday.", "isMe": false, "isAdmin": true},
        {"text": "Free health check-up available.", "isMe": false, "isAdmin": false},
      ]);
    }

    if (widget.isAI) {
      messages.add({
        "text": "Hello! I am your Village AI Assistant. Ask me about water, electricity, road, health etc.",
        "isMe": false,
        "isAdmin": true
      });
    }
  }

  String aiReply(String text) {
    text = text.toLowerCase();

    // Greetings
    if (text.contains("hello") ||
        text.contains("hi") ||
        text.contains("namaste")) {
      return "Hello 👋\nHow can I help you today? You can ask about water supply, electricity, roads, health camps or village updates.";
    }

    // Water related
    else if (text.contains("water") ||
        text.contains("supply")) {
      return "💧 Water supply timing is 7 AM - 9 AM daily.\n\nAre you facing low pressure or no water in your area?";
    }

    // Electricity related
    else if (text.contains("electricity") ||
        text.contains("power") ||
        text.contains("light")) {
      return "⚡ Electricity maintenance is scheduled on Sunday at 2 PM.\n\nIs there a power cut currently in your area?";
    }

    // Road issues
    else if (text.contains("road") ||
        text.contains("repair") ||
        text.contains("pothole")) {
      return "🛣️ Road repair work will start next week near the main market.\n\nCan you tell me the exact location of the issue?";
    }

    // Health
    else if (text.contains("health") ||
        text.contains("hospital") ||
        text.contains("camp") ||
        text.contains("doctor")) {
      return "🏥 Health camp is scheduled on Friday at 10 AM in the community hall.\n\nWould you like details about vaccination or general check-up?";
    }

    // Farming
    else if (text.contains("fertilizer") ||
        text.contains("crop") ||
        text.contains("farm")) {
      return "🌾 Fertilizer distribution starts tomorrow from 9 AM at the agriculture center.\n\nWhich crop are you growing this season?";
    }

    // Default fallback
    else {
      return "I'm your Village AI Assistant 🤖\n\nYou can ask me about:\n• Water supply\n• Electricity\n• Roads\n• Health camps\n• Farming updates\n\nHow can I assist you today?";
    }
  }
  void sendMessage() {
    if (controller.text.trim().isEmpty) return;

    String userMessage = controller.text.trim();

    setState(() {
      messages.add({"text": userMessage, "isMe": true, "isAdmin": false});
    });

    controller.clear();

    if (widget.isAI) {
      Future.delayed(const Duration(milliseconds: 600), () {
        setState(() {
          messages.add({
            "text": aiReply(userMessage),
            "isMe": false,
            "isAdmin": true
          });
        });

        scrollController.animateTo(
          scrollController.position.maxScrollExtent + 100,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F5F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B5E20),
        title: Text(widget.groupName),
      ),
      body: Column(
        children: [

          Expanded(
            child: ListView.builder(
              controller: scrollController,
              padding: const EdgeInsets.all(15),
              itemCount: messages.length,
              itemBuilder: (_, index) {
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
                      "assets/icons/paper-airplane.svg",
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