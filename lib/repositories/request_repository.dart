import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kafka_tool/models/create_new_request_response.dart';
import 'package:kafka_tool/repositories/base.dart';
import 'package:kafka_tool/models/request.dart';

import '../models/list_request_response.dart';
import '../models/public_message_response.dart';

class RequestRepository {
  // CREATE
  Future<dynamic> createRequest(
    String title,
    String topic,
    int numOfMsg,
    String message,
    String msgHeader,
    String msgKey,
  ) async {
    Uri url = Uri.parse("$kafkaToolURL/kafka/requests");
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final response = await http
        .post(
          url,
          headers: headers,
          body: jsonEncode(<String, dynamic>{
            'title': title,
            'topic': topic,
            'quantity': numOfMsg,
            'message': message,
            'header': msgHeader,
            'key': msgKey,
          }),
        )
        .timeout(const Duration(seconds: 60));

    if (response.statusCode == 200) {
      return CreateNewRequestAPIResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to save request');
    }
  }

  // GET
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

  // UPDATE
  Future<dynamic> updateRequest(Request request) async {
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
            'header': request.header,
            'key': request.key,
          }),
        )
        .timeout(const Duration(seconds: 30));

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to update request');
    }
  }

  Future<dynamic> deleteRequest(int requestID) async {
    Uri url = Uri.parse("$kafkaToolURL/kafka/requests/$requestID");
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final response = await http
        .delete(
          url,
          headers: headers,
        )
        .timeout(const Duration(seconds: 30));

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to update request');
    }
  }

/* Call /publish API to send message*/
  Future<PublishMsgAPIResponse> publish(
      String message, int numOfMsg, String topic) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    Uri url = Uri.parse("$kafkaToolURL/kafka/publish");
    final response = await http
        .post(
          url,
          headers: headers,
          body: jsonEncode(<String, dynamic>{
            'message': message,
            'topic': topic,
            'quantity': numOfMsg,
          }),
        )
        .timeout(const Duration(seconds: 60));

    PublishMsgAPIResponse res =
        PublishMsgAPIResponse.fromJson(jsonDecode(response.body));

    return res;
  }
}
