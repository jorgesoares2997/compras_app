class Report {
  final DateTime date;
  final String description;
  final String? issues;
  final String status;

  Report({
    required this.date,
    required this.description,
    this.issues,
    required this.status,
  });
}
