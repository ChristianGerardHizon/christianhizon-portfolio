import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sannjosevet/src/core/models/failure.dart';
import 'package:sannjosevet/src/core/models/type_defs.dart';

class CodeMagicUtils {
  static const _authToken = 'cdnrsdib3HmRoa9-dUrvmD44zYC33nEeqPJTGt2oBpE';

  /// Generates a public URL for an artifact by calling `<baseUrl>/public-url`.
  ///
  /// [baseUrl] is the endpoint root (no trailing slash).
  /// [expiration] is a Duration from now until when the URL should expire.
  ///
  /// Returns a [TaskResult] that, on success, contains the generated URL, or on failure, a [Failure].
  static TaskResult<String> generateArtifact(
    String baseUrl,
    Duration expiration,
  ) {
    return TaskResult.tryCatch(() async {
      final endpoint = Uri.parse('$baseUrl/public-url');

      // Calculate expiration as an epoch integer (seconds).
      final expiresAt =
          DateTime.now().add(expiration).millisecondsSinceEpoch ~/ 1000;

      final response = await http.post(
        endpoint,
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': _authToken,
        },
        body: jsonEncode({
          'expiresAt': expiresAt,
        }),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(
          'Failed to generate public URL (status: ${response.statusCode}): ${response.body}',
        );
      }

      final Map<String, dynamic> body = jsonDecode(response.body);
      if (!body.containsKey('url')) {
        throw Exception('Response JSON does not contain "url": ${response.body}');
      }

      return body['url'] as String;
    }, Failure.handle);
  }
}
