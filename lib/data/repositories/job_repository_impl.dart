import '../../domain/repositories/job_repository.dart';
import '../../domain/entities/job_entity.dart';
import 'job_api_client.dart';

class JobRepositoryImpl implements JobRepository {
  final JobApiClient _apiClient;
  final List<JobEntity> _savedJobs = [];

  JobRepositoryImpl(this._apiClient);

  @override
  Future<List<JobEntity>> fetchJobs() async {
    final jobs = await _apiClient.fetchJobs();
    return jobs
        .map(
          (job) => JobEntity(
            id: job['id'],
            title: job['title'],
            description: job['description'],
            company: job['company'],
            location: job['location'],
            salary: job['salary'],
            jobType: job['jobType'],
            requirements: List<String>.from(job['requirements']),
            postedDate: job['postedDate'],
            isRemote: job['isRemote'],
            isSaved: _savedJobs.any((savedJob) => savedJob.id == job['id']),
          ),
        )
        .toList();
  }

  @override
  Future<void> saveJob(JobEntity job) async {
    if (!_savedJobs.any((savedJob) => savedJob.id == job.id)) {
      _savedJobs.add(job);
    }
  }

  @override
  Future<void> unsaveJob(JobEntity job) async {
    _savedJobs.removeWhere((savedJob) => savedJob.id == job.id);
  }

  @override
  Future<List<JobEntity>> getSavedJobs() async {
    return _savedJobs;
  }
}
