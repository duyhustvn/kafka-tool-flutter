import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kafka_tool/api/base.dart';
import 'package:kafka_tool/models/request.dart';

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

  Future<dynamic> updateRequest(Request request) async {
    debugPrint("$kafkaToolURL/kafka/requests/${request.id}");
    Uri url = Uri.parse("$kafkaToolURL/kafka/requests/${request.id}");
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final response = await http
        .put(
          url,
          headers: headers,
          body: jsonEncode(<String, dynamic>{
            'title': request.title,
            'topic': request.topic,
            'quantity': request.quantity,
            'message': request.message,
          }),
        )
        .timeout(const Duration(seconds: 30));

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to update request');
    }
  }
}
