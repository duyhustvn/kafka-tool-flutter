import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:kafka_tool/api/base.dart';

class Request {
  final String title;
  final String topic;
  final int quantity;
  final String type;
  final String message;

  const Request(
      {required this.title,
      required this.topic,
      required this.quantity,
      required this.type,
      required this.message});

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
        title: json['title'],
        topic: json['topic'],
        quantity: json['quantity'],
        type: json['type'],
        message: json['message']);
  }
}

class ListRequestAPIData {
  final List<Request> requests;

  const ListRequestAPIData({required this.requests});

  factory ListRequestAPIData.fromJson(Map<String, dynamic> json) {
    return ListRequestAPIData(
        requests: List<Request>.from(
            json['requests'].map((rq) => Request.fromJson(rq))));
  }
}

class ListRequestAPIResponse {
  final String status;
  final String? msg;
  final ListRequestAPIData? data;

  const ListRequestAPIResponse({
    required this.status,
    this.msg,
    this.data,
  });

  factory ListRequestAPIResponse.fromJson(Map<String, dynamic> json) {
    return ListRequestAPIResponse(
      status: json['status'],
      msg: json['msg'],
      data: ListRequestAPIData.fromJson(json['data']),
    );
  }
}

/* Call /requests API to list requests*/
Future<ListRequestAPIResponse> listRequests() async {
  final response = await http
      .get(Uri.parse("$kafkaToolURL/kafka/requests"), headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  }).timeout(const Duration(seconds: 60));

  if (response.statusCode == 200) {
    return ListRequestAPIResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to list requests');
  }
}
