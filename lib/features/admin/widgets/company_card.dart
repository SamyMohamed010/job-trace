import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/company.dart';
import '../screens/company_details_screen.dart'; // تأكد من عمل Import للشاشة

class CompanyCard extends StatelessWidget {
  final Company company;

  const CompanyCard({super.key, required this.company});

  @override
  Widget build(BuildContext context) {
    bool isAr = Directionality.of(context) == TextDirection.rtl;
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade100),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    company.logoUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.business, color: Color(0xFF229BD8)),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          company.name,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        if (company.status == 'approved')
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              isAr ? "معتمد" : "Approved",
                              style: const TextStyle(
                                color: Colors.green,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        else if (company.status == 'rejected')
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              isAr ? "مرفوض" : "Rejected",
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    Text(
                      company.email,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF7E848E),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              // زر View المربوط بصفحة التفاصيل
              Expanded(
                child: _buildActionButton(
                  isAr ? "عرض" : "View",
                  Colors.grey[100]!,
                  Colors.black,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CompanyDetailsScreen(company: company),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 8),
              if (!company.isApproved) ...[
                Expanded(
                  child: _buildActionButton(
                    isAr ? "رفض" : "Reject",
                    Colors.red[50]!,
                    Colors.red,
                    () async {
                      if (company.id != null) {
                        final TextEditingController reasonController =
                            TextEditingController();
                        await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(
                              isAr ? "سبب الرفض" : "Rejection reason",
                            ),
                            content: TextField(
                              controller: reasonController,
                              minLines: 3,
                              maxLines: 5,
                              decoration: InputDecoration(
                                hintText: isAr
                                    ? "اكتب سبب الرفض هنا"
                                    : "Enter the rejection reason",
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text(isAr ? "إلغاء" : "Cancel"),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  final reason = reasonController.text.trim();
                                  if (reason.isEmpty) return;
                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(company.id)
                                      .update({
                                        'isApproved': false,
                                        'status': 'rejected',
                                        'rejectionReason': reason,
                                      });
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "${company.name} rejected",
                                        ),
                                      ),
                                    );
                                  }
                                  Navigator.of(context).pop();
                                },
                                child: Text(isAr ? "تأكيد" : "Confirm"),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildActionButton(
                    isAr ? "قبول" : "Approve",
                    const Color(0xFF229BD8),
                    Colors.white,
                    () async {
                      if (company.id != null) {
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(company.id)
                            .update({'isApproved': true, 'status': 'approved'});
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "${company.name} approved successfully",
                              ),
                              backgroundColor: Colors.green,
                            ),
                          );
                        }
                      }
                    },
                  ),
                ),
              ] else
                Expanded(
                  child: _buildActionButton(
                    isAr ? "إلغاء الاعتماد" : "Revoke",
                    Colors.orange[50]!,
                    Colors.orange,
                    () async {
                      if (company.id != null) {
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(company.id)
                            .update({'isApproved': false, 'status': 'pending'});
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Approval revoked for ${company.name}",
                              ),
                            ),
                          );
                        }
                      }
                    },
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  // الودجت المحدثة عشان تقبل وظيفة عند الضغط
  Widget _buildActionButton(
    String label,
    Color bgColor,
    Color textColor,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 95,
        height: 35,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: textColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
