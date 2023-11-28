import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:kafka_tool/api/base.dart';

class ListTopicAPIData {
  final List<String> topics;

  const ListTopicAPIData({required this.topics});

  factory ListTopicAPIData.fromJson(Map<String, dynamic> json) {
    List<String> topics = List<String>.from(json['topics']);
    return ListTopicAPIData(topics: topics);
  }

  Map<String, dynamic> toJson() => {"topics": topics};
}

class ListTopicAPIResponse {
  final String status;
  final String? msg;
  final ListTopicAPIData? data;

  const ListTopicAPIResponse({
    required this.status,
    this.data,
    this.msg,
  });

  factory ListTopicAPIResponse.fromJson(Map<String, dynamic> json) {
    return ListTopicAPIResponse(
      status: json['status'],
      data: ListTopicAPIData.fromJson(json['data']),
      msg: json['msg'],
    );
  }

  Map<String, dynamic> toJson() =>
      {'status': status, 'data': data?.toJson(), 'msg': msg};
}

/* Call /publish API to send message*/
Future<ListTopicAPIResponse> listTopics() async {
  final response = await http
      .get(Uri.parse("$kafkaToolURL/kafka/topics"), headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  }).timeout(const Duration(seconds: 60));

  if (response.statusCode == 200) {
    return ListTopicAPIResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to publish message');
  }
}
