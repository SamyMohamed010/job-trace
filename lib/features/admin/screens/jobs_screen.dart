import 'package:flutter/material.dart';
import '../models/job.dart';
import '../widgets/job_card.dart';

class JobsScreen extends StatelessWidget {
  const JobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // البيانات
    final List<Job> jobs = [
      Job(
        position: "Software Engineer",
        companyName: "Google",
        location: "USA, CA",
        salary: "\$150k",
        logoUrl: "https://img.icons8.com/color/512/google-logo.png",
      ),
      Job(
        position: "UI/UX Designer",
        companyName: "Apple",
        location: "USA, NY",
        salary: "\$120k",
        logoUrl: "https://img.icons8.com/ios-filled/512/mac-os.png",
      ),
      Job(
        position: "Backend Developer",
        companyName: "Microsoft",
        location: "Remote",
        salary: "\$140k",
        logoUrl: "https://img.icons8.com/color/512/microsoft.png",
      ),
    ];

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // عرض الكروت
            ...jobs.map((job) => JobCard(job: job)),
          ],
        ),
      ),
    );
  }
}
