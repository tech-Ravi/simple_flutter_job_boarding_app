import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'presentation/bloc/job_bloc.dart';
import 'presentation/bloc/job_event.dart';
import 'presentation/bloc/job_state.dart';
import 'data/repositories/job_repository_impl.dart';
import 'data/repositories/job_api_client.dart';
import 'presentation/screens/job_list_screen.dart';
import 'presentation/screens/saved_jobs_screen.dart';
import 'presentation/providers/theme_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final jobApiClient = JobApiClient();
    final jobRepository = JobRepositoryImpl(jobApiClient);

    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => JobBloc(jobRepository)..add(FetchJobs()),
              ),
            ],
            child: MaterialApp(
              title: 'Job Search App',
              theme: themeProvider.themeData,
              debugShowCheckedModeBanner: false,
              home: const JobListScreen(),
              routes: {'/saved': (context) => const SavedJobsScreen()},
            ),
          );
        },
      ),
    );
  }
}
