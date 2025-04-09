import '../entities/job_entity.dart';

abstract class JobRepository {
  Future<List<JobEntity>> fetchJobs();
  Future<void> saveJob(JobEntity job);
  Future<void> unsaveJob(JobEntity job);
  Future<List<JobEntity>> getSavedJobs();
}
