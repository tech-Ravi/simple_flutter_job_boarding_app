class JobEntity {
  final int id;
  final String title;
  final String description;
  final String company;
  final String location;
  final String salary;
  final String jobType;
  final List<String> requirements;
  final String postedDate;
  final bool isRemote;
  final bool isSaved;

  JobEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.company,
    required this.location,
    required this.salary,
    required this.jobType,
    required this.requirements,
    required this.postedDate,
    required this.isRemote,
    this.isSaved = false,
  });
}
