import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:kafka_tool/repositories/base.dart';

class BrokerRepository {
  Future<dynamic> connectKafkaBrokers(String brokers) async {
    Uri url = Uri.parse("$kafkaToolURL/kafka/brokers/connect");
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final response = await http
        .post(
          url,
          headers: headers,
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
}
