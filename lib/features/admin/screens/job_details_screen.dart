import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // تأكد من إضافة المكتبة في pubspec.yaml
import '../models/job.dart';

class JobDetailsScreen extends StatefulWidget {
  final Job job;

  const JobDetailsScreen({super.key, required this.job});

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  // متغير للتحكم في حالة الإشعارات (تفعيل/إلغاء)
  bool _isNotificationActive = false;

  // دالة لفتح الخريطة بناءً على اسم الموقع
  Future<void> _openMap() async {
    final String query = Uri.encodeComponent(widget.job.location);
    final Uri googleMapsUrl = Uri.parse(
      "https://www.google.com/maps/search/?api=1&query=$query",
    );

    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("Could not open the map.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBEEF4),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.orange,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          // زر الإشعارات التفاعلي
          IconButton(
            icon: Icon(
              _isNotificationActive
                  ? Icons.notifications_active
                  : Icons.notifications_none,
              color: Colors.orange,
            ),
            onPressed: () {
              setState(() {
                _isNotificationActive = !_isNotificationActive;
              });
              // إظهار رسالة بسيطة للمستخدم
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    _isNotificationActive
                        ? "Notifications Turned On"
                        : "Notifications Turned Off",
                  ),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Center(
              child: Image.network(
                widget.job.logoUrl,
                height: 80,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.business, size: 80),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.job.position,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              widget.job.companyName,
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 15),

            // الموقع (اللوكيشن) أصبح قابل للضغط ويفتح الخريطة
            InkWell(
              onTap: _openMap,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.location_on, color: Colors.red, size: 18),
                  Text(
                    " ${widget.job.location} • Hybrid",
                    style: const TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildInfoTag("From 10,000 EGP To 15,000 EGP"),
                const SizedBox(width: 10),
                _buildInfoTag("Part-time", icon: Icons.business_center),
              ],
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(),
                  const SizedBox(height: 20),
                  const Text(
                    "Job Description",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Designs, develops, and tests software for Google's products and services, working on innovative projects and collaborating with teams.",
                    style: TextStyle(color: Colors.grey, height: 1.5),
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 20),
                  const Row(
                    children: [
                      Text(
                        "Job Requirements",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_down, color: Colors.blue),
                    ],
                  ),
                  const SizedBox(height: 15),
                  _buildRequirementItem("C++"),
                  _buildRequirementItem("HTML/CSS"),
                  _buildRequirementItem("Soft Skills"),
                  _buildRequirementItem("English Language"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTag(String text, {IconData? icon}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 5),
        ],
      ),
      child: Row(
        children: [
          if (icon != null) Icon(icon, size: 16, color: Colors.grey),
          if (icon != null) const SizedBox(width: 5),
          Text(
            text,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildRequirementItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          const Icon(Icons.check, color: Colors.orange, size: 18),
          const SizedBox(width: 10),
          Text(text, style: const TextStyle(color: Colors.grey, fontSize: 14)),
        ],
      ),
    );
  }
}
