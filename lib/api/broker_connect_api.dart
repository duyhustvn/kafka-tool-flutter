import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:kafka_tool/api/base.dart';

Future<dynamic> connectKafkaBrokers(String brokers) async {
  final response = await http
      .post(
        Uri.parse("$kafkaToolURL/kafka/brokers/connect"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'brokers_url': brokers,
        }),
      )
      .timeout(const Duration(seconds: 60));
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception('Failed to connect kafka broker');
  }
}
