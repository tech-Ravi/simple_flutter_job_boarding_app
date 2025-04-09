import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../domain/entities/job_entity.dart';
import '../../domain/repositories/job_repository.dart';
import 'job_event.dart';
import 'job_state.dart';

class JobBloc extends Bloc<JobEvent, JobState> {
  final JobRepository _jobRepository;
  final List<JobEntity> _savedJobs = [];

  JobBloc(this._jobRepository) : super(JobInitial()) {
    on<FetchJobs>((event, emit) async {
      emit(JobLoading());
      try {
        final jobs = await _jobRepository.fetchJobs();
        emit(JobLoaded(jobs, savedJobs: _savedJobs));
      } catch (e) {
        emit(JobError(e.toString()));
      }
    });

    on<ToggleBookmark>((event, emit) {
      final isSaved = _savedJobs.any((job) => job.id == event.job.id);
      if (isSaved) {
        _savedJobs.removeWhere((job) => job.id == event.job.id);
        _jobRepository.unsaveJob(event.job);
        Fluttertoast.showToast(
          msg: 'Job removed from saved jobs',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey[800],
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        _savedJobs.add(event.job);
        _jobRepository.saveJob(event.job);
        Fluttertoast.showToast(
          msg: 'Job saved successfully',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey[800],
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
      if (state is JobLoaded) {
        emit(JobLoaded((state as JobLoaded).jobs, savedJobs: _savedJobs));
      }
    });
  }
}
