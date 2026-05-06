class Job {
  final String id;
  final String companyId;
  final String position;
  final String companyName;
  final String location;
  final String salary;
  final String logoUrl;
  final String status;

  Job({
    required this.id,
    required this.companyId,
    required this.position,
    required this.companyName,
    required this.location,
    required this.salary,
    required this.logoUrl,
    this.status = 'pending',
  });
}
