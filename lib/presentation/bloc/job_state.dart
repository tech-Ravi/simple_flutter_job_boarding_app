import '../../domain/entities/job_entity.dart';

abstract class JobState {
  List<JobEntity> get savedJobs => [];
}

class JobInitial extends JobState {}

class JobLoading extends JobState {}

class JobLoaded extends JobState {
  final List<JobEntity> jobs;
  final List<JobEntity> savedJobs;

  JobLoaded(this.jobs, {this.savedJobs = const []});
}

class JobError extends JobState {
  final String message;

  JobError(this.message);
}
