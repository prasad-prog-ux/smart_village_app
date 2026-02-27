import 'package:flutter/material.dart';

class Complaint {
  final String id;
  final String title;
  final String description;
  final String category;
  final String status;
  final String date;
  final String location;
  final String department;
  final String phone;
  final String email;
  final Color statusColor;
  final Color statusColor2;

  Complaint({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.status,
    required this.date,
    required this.location,
    required this.department,
    required this.phone,
    required this.email,
    required this.statusColor,
    required this.statusColor2,
  });
}

List<Complaint> complaints = [
  Complaint(
    id: "101",
    title: "Street Light Not Working",
    description: "The street light near the temple is not working.",
    category: "Infrastructure",
    status: "Pending",
    date: "20 Feb 2026",
    location: "Ward 3",
    department: "Electricity Dept",
    phone: "9876543210",
    email: "electric@village.in",
    statusColor: Colors.orange,
    statusColor2: Colors.orange.shade50,
  ),
];