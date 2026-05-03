import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../localization.dart';
import '../../widgets/language_toggle.dart';

class CompanyProfileScreen extends StatefulWidget {
  const CompanyProfileScreen({super.key});

  @override
  State<CompanyProfileScreen> createState() => _CompanyProfileScreenState();
}

class _CompanyProfileScreenState extends State<CompanyProfileScreen> {
  bool _isExpanded = false;

  // دالة لإظهار الإشعارات من الأسفل (Bottom Sheet)
  void _showNotificationsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min, // تخليه ياخد مساحة المحتوى بس
            children: [
              const Text("Notifications", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              _buildNotificationItem(Icons.check_circle, Colors.green, "Application Accepted", "Your application for Google has been accepted."),
              _buildNotificationItem(Icons.info, Colors.blue, "New Job Alert", "A new 'Flutter Developer' job was posted."),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNotificationItem(IconData icon, Color color, String title, String subtitle) {
    return ListTile(
      leading: Icon(icon, color: color, size: 30),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBEEF4),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFFFDA00C), size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          const LanguageToggle(),
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded, color: Color(0xFFFDA00C), size: 24),
            onPressed: () => _showNotificationsBottomSheet(context), // تغيير هنا
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 45,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('assets/images/organic.jpg'),
            ),
            const SizedBox(height: 10),
            const Text("Organic", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.location_on, color: Colors.redAccent, size: 18),
                const SizedBox(width: 5),
                InkWell(
                  onTap: () async {
                    final Uri url = Uri.parse("https://www.google.com/maps/search/?api=1&query=Cairo,+Egypt");
                    if (await canLaunchUrl(url)) await launchUrl(url);
                  },
                  child: const Text(
                    "Cairo, Egypt",
                    style: TextStyle(color: Colors.grey, decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),

            _buildSectionCard(
              title: AppLocale.tr(context, "About Organic"),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocale.tr(context, "A leading manufacturer and distributor of high-quality pharmaceutical products, dedicated to improving public health."),
                    maxLines: _isExpanded ? 10 : 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.black54, height: 1.5),
                  ),
                  InkWell(
                    onTap: () => setState(() => _isExpanded = !_isExpanded),
                    child: Text(AppLocale.tr(context, _isExpanded ? "See less" : "See more >"), style: const TextStyle(color: Color(0xFF229BD8), fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            Align(alignment: Alignment.centerLeft, child: Text(AppLocale.tr(context, "Posted Jobs"), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
            const SizedBox(height: 15),

            _buildJobItem(AppLocale.tr(context, "Pharmaceutical Control"), AppLocale.tr(context, "Cairo, Egypt"), AppLocale.tr(context, "Full-Time")),
            _buildJobItem(AppLocale.tr(context, "Quality Analyst"), AppLocale.tr(context, "Alexandria, Egypt"), AppLocale.tr(context, "Internship")),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10, offset: const Offset(0, 4))]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        child,
      ]),
    );
  }

  Widget _buildJobItem(String title, String location, String type) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10, offset: const Offset(0, 4))]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // يضمن ظهور المحتوى من البداية
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const CircleAvatar(backgroundColor: Color(0xFFEBEEF4), child: Icon(Icons.medication, color: Color(0xFF229BD8))),
            title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            trailing: Text(type, style: const TextStyle(color: Color(0xFF229BD8))),
          ),
          const Divider(),
          // تصليح ظهور اللوكيشن تماماً
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.redAccent, size: 18),
              const SizedBox(width: 5),
              Expanded( // يضمن إن النص ما يزحمش الأيقونة
                child: InkWell(
                  onTap: () async {
                    final Uri url = Uri.parse("https://www.google.com/maps/search/?api=1&query=$location");
                    if (await canLaunchUrl(url)) await launchUrl(url);
                  },
                  child: Text(
                    location,
                    style: const TextStyle(color: Colors.grey, decoration: TextDecoration.underline),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}