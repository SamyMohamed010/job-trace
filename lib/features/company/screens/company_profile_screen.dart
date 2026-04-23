import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../company_data.dart';
import 'company_edit_profile_screen.dart';

class CompanyProfileScreen extends StatefulWidget {
  @override
  _CompanyProfileScreenState createState() => _CompanyProfileScreenState();
}

class _CompanyProfileScreenState extends State<CompanyProfileScreen> {
  void _refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final data = CompanyData();
    
    return Scaffold(
      backgroundColor: const Color(0xFFEBEEF4),
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // App Logo Placeholder (Top Left)
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: const Icon(Icons.business, color: Color(0xFF229BD8), size: 20),
                  ),
                  const Icon(Icons.notifications, color: Color(0xFFFDA00C)),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Company Logo (Center)
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF1E3A8A), // Dark blue
                        border: Border.all(color: Colors.white, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: data.logoImage != null
                          ? ClipOval(
                              child: kIsWeb
                                  ? Image.network(data.logoImage!.path, fit: BoxFit.cover, width: 80, height: 80)
                                  : Image.file(File(data.logoImage!.path), fit: BoxFit.cover, width: 80, height: 80),
                            )
                          : Center(
                              child: Text(
                                data.name.isNotEmpty ? data.name[0].toUpperCase() : "S", 
                                style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)
                              ),
                            ),
                    ),
                    const SizedBox(height: 12),

                    // Company Name
                    Text(
                      data.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Industry
                    Text(
                      data.industry,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF7E848E),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Location
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.location_on, color: Colors.redAccent, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          data.location,
                          style: const TextStyle(color: Color(0xFF7E848E), fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),

                    // Website
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.language, color: Color(0xFF7E848E), size: 16),
                        const SizedBox(width: 4),
                        Text(
                          data.website,
                          style: const TextStyle(color: Color(0xFF7E848E), fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // About Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "About ${data.name}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            data.overview,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF7E848E),
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Edit Profile Button
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CompanyEditProfileScreen()),
                          );
                          if (result == true) {
                            _refresh();
                          }
                        },
                        icon: const Icon(Icons.edit, size: 16, color: Colors.white),
                        label: const Text(
                          "Edit Profile",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF229BD8),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Divider
                    const Divider(color: Colors.grey, thickness: 0.5),
                    const SizedBox(height: 40),

                    // Empty State - No Jobs
                    const Icon(
                      Icons.work_outline,
                      size: 60,
                      color: Color(0xFFB0B5BD),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "No jobs yet",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF7E848E),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
