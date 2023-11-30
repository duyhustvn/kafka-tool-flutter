import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:kafka_tool/api/base.dart';

/* Call create request API to send message*/
Future<dynamic> createRequest(
    String title, String topic, int numOfMsg, String message) async {
  final response = await http
      .post(
        Uri.parse("$kafkaToolURL/kafka/requests"),
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
    throw Exception('Failed to save request');
  }
}
