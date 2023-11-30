import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:kafka_tool/api/base.dart';

/* Call update request API to send message*/
Future<dynamic> updateRequest(
    String id, String title, String topic, int numOfMsg, String message) async {
  final response = await http
      .put(
        Uri.parse("$kafkaToolURL/kafka/requests/$id"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'title': title,
          'topic': topic,
          'quantity': numOfMsg,
          'message': message,
        }),
      )
      .timeout(const Duration(seconds: 60));

  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception('Failed to update request');
  }
}
