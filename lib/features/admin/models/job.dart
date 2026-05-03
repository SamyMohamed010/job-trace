class Job {
  final String position; // مسمى الوظيفة (مثلاً Flutter Developer)
  final String companyName; // اسم الشركة
  final String location; // المكان
  final String salary; // الراتب
  final String logoUrl; // صورة الشركة

  Job({
    required this.position,
    required this.companyName,
    required this.location,
    required this.salary,
    required this.logoUrl,
  });
}
