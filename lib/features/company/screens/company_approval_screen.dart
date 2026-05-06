import 'package:flutter/material.dart';

class CompanyApprovalScreen extends StatelessWidget {
  final String status;
  final String rejectionReason;

  const CompanyApprovalScreen({
    super.key,
    this.status = 'pending',
    this.rejectionReason = '',
  });

  @override
  Widget build(BuildContext context) {
    final bool isRejected = status == 'rejected';
    final String title = isRejected
        ? "Your request has been rejected."
        : "Your request has been submitted and\nis waiting for approval.";
    final String subtitle = isRejected
        ? "Your company registration was rejected by the admin."
        : "We will notify you once it's been reviewed.";

    return Scaffold(
      backgroundColor: const Color(0xFFEBEEF4),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              if (isRejected)
                const Icon(Icons.cancel, size: 120, color: Colors.red)
              else
                Image.asset(
                  'assets/images/waiting_approval.png',
                  height: 200,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.hourglass_empty,
                      size: 100,
                      color: Color(0xFFFDA00C),
                    );
                  },
                ),
              const SizedBox(height: 40),

              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF7E848E),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),

              const Divider(
                color: Color(0xFF7E848E),
                thickness: 0.5,
                indent: 40,
                endIndent: 40,
              ),
              const SizedBox(height: 24),

              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: Color(0xFF7E848E)),
              ),
              if (isRejected) ...[
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.red.withOpacity(0.2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Rejection reason",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        rejectionReason.isNotEmpty
                            ? rejectionReason
                            : "No reason provided.",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF7E848E),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 40),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildDot(const Color(0xFFD3D3D3)),
                  const SizedBox(width: 8),
                  _buildDot(const Color(0xFF7E848E)),
                  const SizedBox(width: 8),
                  _buildDot(const Color(0xFF7E848E)),
                ],
              ),
              const Spacer(),

              // --- الزرار الجديد للعودة للـ Login ---
              SizedBox(
                width: 200,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/login',
                      (route) => false,
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: const BorderSide(color: Color(0xFF229BD8), width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    "Back to Login",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF229BD8),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12), // مسافة بين الزرارين
              // Cancel Request Button
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/company_register_step1',
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: const Color(0xFF229BD8),
                  ),
                  child: const Text(
                    "Cancel Request",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDot(Color color) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
