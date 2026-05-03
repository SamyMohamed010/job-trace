import 'package:flutter/material.dart';

class ApplicationsScreen extends StatelessWidget {
  const ApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryBlue = const Color(0xFF229BD8);
    final Color grayBg = const Color(0xFFEBEEF4);

    final List<Map<String, String>> applications = [
      {
        "title": "Flutter Developer Intern",
        "company": "Vodafone Egypt",
        "status": "Accepted",
        "date": "Applied 2 days ago"
      },
      {
        "title": "UI/UX Designer",
        "company": "Google Egypt",
        "status": "Pending",
        "date": "Applied 1 week ago"
      },
      {
        "title": "Data Analyst",
        "company": "Amazon",
        "status": "Viewed",
        "date": "Applied 3 days ago"
      },
    ];

    return Scaffold(
      backgroundColor: grayBg,
      appBar: AppBar(
        title: const Text("My Applications", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF333333),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: applications.length,
        itemBuilder: (context, index) {
          final app = applications[index];
          return _buildApplicationCard(app, primaryBlue);
        },
      ),
    );
  }

  Widget _buildApplicationCard(Map<String, String> app, Color accentColor) {
    Color statusColor;
    switch (app["status"]) {
      case "Accepted":
        statusColor = Colors.green;
        break;
      case "Pending":
        statusColor = Colors.orange;
        break;
      case "Viewed":
        statusColor = Colors.blue;
        break;
      default:
        statusColor = Colors.grey;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Row(
        children: [
          Container(
            height: 50, width: 50,
            decoration: BoxDecoration(color: accentColor.withOpacity(0.1), shape: BoxShape.circle),
            child: Icon(Icons.business, color: accentColor),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(app["title"]!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1E3A5F))),
                const SizedBox(height: 4),
                Text(app["company"]!, style: const TextStyle(color: Colors.grey, fontSize: 14)),
                const SizedBox(height: 8),
                Text(app["date"]!, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              app["status"]!,
              style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
