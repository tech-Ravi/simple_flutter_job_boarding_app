import '../../domain/entities/job_entity.dart';

abstract class JobEvent {}

class FetchJobs extends JobEvent {}

class ToggleBookmark extends JobEvent {
  final JobEntity job;

  ToggleBookmark(this.job);
}
