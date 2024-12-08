// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  Future<Map<String, dynamic>> sendPostRequest(
      List<Map<String, dynamic>> data) async {
    final Uri apiUrl = Uri.parse(dotenv.env['URL']!);

    try {
      final response = await http.post(
        apiUrl,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        print('Response data: $responseData');
        return responseData; // Return the response data
      } else {
        print('Failed to submit data. Status code: ${response.statusCode}');
        return {}; // Return an empty map in case of failure
      }
    } catch (e) {
      print('Error: $e');
      return {}; // Return an empty map in case of error
    }
  }
}
