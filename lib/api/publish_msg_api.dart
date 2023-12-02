import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:kafka_tool/api/base.dart';

/* Call /publish API to send message*/
Future<PublishMsgAPIResponse> publish(
    String message, int numOfMsg, String topic) async {
  final response = await http
      .post(
        Uri.parse("$kafkaToolURL/kafka/publish"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
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

class PublishMsgAPIData {
  final int totalMessage;
  final int success;
  final int failed;

  const PublishMsgAPIData(
      {required this.totalMessage,
      required this.success,
      required this.failed});

  factory PublishMsgAPIData.fromJson(Map<String, dynamic> json) {
    return PublishMsgAPIData(
      totalMessage: json['totalMessage'],
      success: json['success'],
      failed: json['failed'],
    );
  }

  Map<String, dynamic> toJson() =>
      {'totalMessage': totalMessage, 'success': success, 'failed': failed};
}

/* {"status":"ok","data":{"totalMessage":1,"success":1,"failed":0}} */
class PublishMsgAPIResponse {
  final String status;
  final String? msg;
  final PublishMsgAPIData? data;

  const PublishMsgAPIResponse({
    required this.status,
    this.data,
    this.msg,
  });

  factory PublishMsgAPIResponse.fromJson(Map<String, dynamic> json) {
    return PublishMsgAPIResponse(
      status: json['status'],
      data: json['data'] != null
          ? PublishMsgAPIData.fromJson(json['data'])
          : null,
      msg: json['msg'],
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'data': data?.toJson(),
        'msg': msg,
      };
}
