import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kafka_tool/api/base.dart';

import '../models/list_request_response.dart';

class RequestRepository {
  Future<ListRequestAPIResponse> fetchRequests() async {
    Uri url = Uri.parse("$kafkaToolURL/kafka/requests");
    Map<String, String> headers = {
      'content-type': 'application/json; charset=UTF-8'
    };
    final response = await http
        .get(url, headers: headers)
        .timeout(const Duration(seconds: 60));

    if (response.statusCode == 200) {
      return ListRequestAPIResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to list requests');
    }
  }
}
