import 'package:flutter/material.dart';
import 'company_profile_screen.dart';
import '../../localization.dart';
import '../../widgets/language_toggle.dart';
import 'company_profile_screen.dart'; 
class JobDetailsScreen extends StatefulWidget {
  // تعريف المتغيرات في الـ Widget لتكون قابلة للاستخدام في الـ State
  final String title;
  final String company;
  final String location;

  const JobDetailsScreen({
    super.key, 
    required this.title, 
    required this.company, 
    required this.location,
  });

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  bool _isDescriptionExpanded = false;
  bool _isApplied = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBEEF4),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 110,
        leading: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Color(0xFFFDA00C), size: 20),
              onPressed: () => Navigator.pop(context),
            ),
            // لوجو التطبيق الصغير - تأكدي من وجوده في المسار المذكور
            Image.asset(
              'assets/images/logo.jpg', 
              height: 32, 
              width: 32,
              color: const Color(0xFFEBEEF4),
              colorBlendMode: BlendMode.multiply,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.circle, size: 32, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          const LanguageToggle(),
          IconButton(
            icon: const Icon(Icons.notifications_active_outlined, color: Color(0xFFFDA00C), size: 24),
            onPressed: () => _showNotifications(context),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // لوجو الشركة المظبوط (Google)
            Center(
              child: Container(
                height: 100, width: 100,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10, offset: const Offset(0, 4))],
                ),
                child: Image.asset(
                  'assets/images/google.png',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.business, size: 50, color: Color(0xFF1B4B82)),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Text(widget.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(widget.company, style: const TextStyle(color: Color(0xFF7E848E), fontSize: 18)),
            const SizedBox(height: 20),
            
            // الموقع والراتب
            Wrap(
              spacing: 10,
              alignment: WrapAlignment.center,
              children: [
                _buildInfoChip(Icons.location_on, widget.location, Colors.red),
                _buildInfoChip(Icons.monetization_on, "5k - 7k EGP", Colors.green),
                _buildInfoChip(Icons.work, "Hybrid", Colors.blue),
              ],
            ),
            
            const SizedBox(height: 30),
            _buildSectionTitle(AppLocale.tr(context, "Job Description")),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocale.tr(context, "We are looking for a creative developer to join our team in Cairo. This role involves designing and implementing high-quality user interfaces."),
                  maxLines: _isDescriptionExpanded ? 10 : 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.black54, height: 1.5),
                ),
                InkWell(
                  onTap: () => setState(() => _isDescriptionExpanded = !_isDescriptionExpanded),
                  child: Text(
                    AppLocale.tr(context, _isDescriptionExpanded ? "See less" : "See more >"),
                    style: const TextStyle(color: Color(0xFF229BD8), fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),
            // قائمة المتطلبات المنسدلة (التي طلبتِها بالسهم)
            Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                title: Text(AppLocale.tr(context, "Job Requirements"), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
                tilePadding: EdgeInsets.zero,
                iconColor: const Color(0xFF1B4B82),
                children: [
                  _buildReqItem(AppLocale.tr(context, "Bachelor's degree in Computer Science.")),
                  _buildReqItem(AppLocale.tr(context, "Strong experience with Flutter and Dart.")),
                  _buildReqItem(AppLocale.tr(context, "Professional English language.")),
                ],
              ),
            ),

            const SizedBox(height: 40),
            // زر التقديم (يتغير عند الضغط)
            ElevatedButton(
              onPressed: () {
                setState(() => _isApplied = true);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppLocale.tr(context, "Applied Successfully!"))));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _isApplied ? const Color(0xFF7E848E) : const Color(0xFF229BD8),
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
              child: Text(AppLocale.tr(context, _isApplied ? "Applied" : "Apply Now"), style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            
            const SizedBox(height: 15),
            // زر عرض الشركة
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CompanyProfileScreen()));
              },
              child: Text(AppLocale.tr(context, "View Company Profile"), style: const TextStyle(color: Color(0xFF229BD8), decoration: TextDecoration.underline, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
      // شريط التنقل السفلي
   
    );
  }

  // --- دوال مساعدة لترتيب الكود ---
  Widget _buildSectionTitle(String title) => Align(alignment: Alignment.centerLeft, child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)));

  Widget _buildReqItem(String text) => Padding(padding: const EdgeInsets.only(bottom: 10), child: Row(children: [const Icon(Icons.check_circle, size: 18, color: Color(0xFFFDA00C)), const SizedBox(width: 10), Expanded(child: Text(text, style: const TextStyle(color: Colors.black54)))]));

  Widget _buildInfoChip(IconData icon, String label, Color color) => Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(20)), child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(icon, size: 16, color: color), const SizedBox(width: 6), Text(label, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12))]));

  void _showNotifications(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    builder: (context) => Container(
      padding: const EdgeInsets.all(20),
      height: 350,
      child: Column(
        children: [
          const Text("Notifications", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const Divider(),
          const SizedBox(height: 10),
          ListTile(
            leading: const Icon(Icons.check_circle, color: Colors.green, size: 30),
            title: const Text("Application Accepted", style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text("Your application for Google has been accepted!"),
            trailing: const Text("Now", style: TextStyle(color: Colors.grey, fontSize: 12)),
          ),
          const Divider(),
        ],
      ),
    ),
  );
}
}