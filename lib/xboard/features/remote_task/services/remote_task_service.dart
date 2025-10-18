import 'package:dio/dio.dart';
class RemoteTaskService {
  final Dio _dio = Dio();
  Future<Map<String, dynamic>> executeHttpRequest({
    required String url,
    String method = 'GET',
    Map<String, dynamic>? headers,
    dynamic body,
  }) async {
    final stopwatch = Stopwatch()..start();
    try {
      final options = Options(
        method: method,
        headers: headers,
      );
      final response = await _dio.request(
        url,
        data: body,
        options: options,
      );
      stopwatch.stop();
      return {
        'status': 'success',
        'statusCode': response.statusCode,
        'headers': response.headers.map,
        'body': response.data,
        'latency': stopwatch.elapsedMilliseconds,
      };
    } on DioException catch (e) {
      stopwatch.stop();
      return {
        'status': 'error',
        'errorMessage': e.message,
        'statusCode': e.response?.statusCode,
        'latency': stopwatch.elapsedMilliseconds,
      };
    } catch (e) {
      stopwatch.stop();
      return {
        'status': 'error',
        'errorMessage': e.toString(),
        'latency': stopwatch.elapsedMilliseconds,
      };
    }
  }
}
