import 'package:dio/dio.dart';
import '../services/api_service.dart';
import '../mock/mock_jobs.dart';

class JobApiClient {
  final ApiService _apiService;

  JobApiClient() : _apiService = ApiService();

  Future<List<Map<String, dynamic>>> fetchJobs() async {
    try {
      final response = await _apiService.get('/jobs');
      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(response.data);
      } else {
        throw Exception('Failed to load jobs');
      }
    } catch (e) {
      // Fallback to mock data if API call fails
      return MockJobs.jobs;
    }
  }
}
