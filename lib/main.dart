import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home: const TabBarExample(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var callPublishMsgsDone = false;
}

class TabBarExample extends StatelessWidget {
  const TabBarExample({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Kafka Tool'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Publish',
              ),
              Tab(
                text: 'Subscribe',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            const BuildPublishWidget(),
            const Center(
              child: Text(""),
            ),
          ],
        ),
      ),
    );
  }
}

class BuildPublishWidget extends StatefulWidget {
  const BuildPublishWidget({super.key});

  @override
  State<BuildPublishWidget> createState() => _BuildPublishWidgetState();
}

class _BuildPublishWidgetState extends State<BuildPublishWidget> {
  final messageBodyController = TextEditingController();
  final numMessageController = TextEditingController();
  final topicController = TextEditingController();
  final responseController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          maxLines: 5,
          controller: messageBodyController,
          decoration: const InputDecoration(
            labelText: 'Message',
          ),
        ),
        TextFormField(
          maxLines: 1,
          controller: numMessageController,
          decoration: const InputDecoration(
            labelText: 'Number Of message',
          ),
        ),
        TextFormField(
          maxLines: 1,
          controller: topicController,
          decoration: const InputDecoration(
            labelText: 'Topic',
          ),
        ),
        // Reponse
        TextFormField(
          maxLines: 3,
          controller: responseController,
        ),
        const SizedBox(height: 5),
        ElevatedButton(
          onPressed: () async {
            var numOfMsg = int.tryParse(numMessageController.text);
            var res = await publish(
              messageBodyController.text,
              numOfMsg ?? 1, // if numOfMsg is null default value is 1
              topicController.text,
            );

            responseController.text =
                "total message: ${res.totalMessage} \nsuccess: ${res.success} \nfailed: ${res.failed}";
          },
          child: const Text("Publish"),
        )
      ],
    );
  }
}

Future<PublishResponse> publish(
    String message, int numOfMsg, String topic) async {
  final response = await http
      .post(
        Uri.parse("http://127.0.0.1:9000"),
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

  if (response.statusCode == 201) {
    return PublishResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to publish message');
  }
}

class PublishResponse {
  final int totalMessage;
  final int success;
  final int failed;

  const PublishResponse(
      {required this.totalMessage,
      required this.success,
      required this.failed});

  factory PublishResponse.fromJson(Map<String, dynamic> json) {
    return PublishResponse(
      totalMessage: json['totalMessage'],
      success: json['success'],
      failed: json['failed'],
    );
  }

  Map toJson() =>
      {'totalMessage': totalMessage, 'success': success, 'failed': failed};
}
