import 'dart:convert';

import 'package:kafka_tool/api/base.dart';
import 'package:kafka_tool/api/topic_list_api.dart';
import 'package:http/http.dart' as http;

class TopicRepository {
  Future<ListTopicAPIResponse> listTopics() async {
    final response = await http
        .get(Uri.parse("$kafkaToolURL/kafka/topics"), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    }).timeout(const Duration(seconds: 60));

    if (response.statusCode == 200) {
      return ListTopicAPIResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to list topic');
    }
  }
}
