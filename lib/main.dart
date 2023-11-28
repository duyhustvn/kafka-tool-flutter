import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:kafka_tool/api/publish_msg_api.dart';
import 'package:kafka_tool/api/topic_list_api.dart';
import 'package:kafka_tool/api/request_list_api.dart';

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
        home: const KafkaTabBar(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var callPublishMsgsDone = false;
}

class KafkaTabBar extends StatelessWidget {
  const KafkaTabBar({super.key});
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
  String? selectedTopic;

  List<String> topics = [];
  List<Request> requests = [];

  @override
  void initState() {
    super.initState();
    _listTopics();
    _listRequests();
  }

  Future<void> _listTopics() async {
    try {
      final res = await listTopics();
      if (res.status == 'ok') {
        setState(() {
          topics = res.data!.topics;
        });
      }
    } catch (e) {
      print("Error loading topics: $e");
    }
  }

  Future<void> _listRequests() async {
    try {
      final res = await listRequests();
      if (res.status == 'ok') {
        setState(() {
          requests = res.data!.requests;
        });
      }
    } catch (e) {
      print("Error loading requests: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          const SizedBox(height: 7),
          Row(
            children: [
              DropdownMenu(
                // initialSelection: selectedTopic,
                controller: topicController,
                width: 200.0,
                // requestFocusOnTap is enabled/disabled by platforms when it is null.
                // On mobile platforms, this is false by default. Setting this to true will
                // trigger focus request on the text field and virtual keyboard will appear
                // afterward. On desktop platforms however, this defaults to true.
                requestFocusOnTap: true,
                label: const Text('Title'),
                onSelected: (String? topic) {
                  setState(() {
                    selectedTopic = topic;
                  });
                },
                dropdownMenuEntries:
                    topics.map<DropdownMenuEntry<String>>((String topic) {
                  return DropdownMenuEntry<String>(value: topic, label: topic);
                }).toList(),
              ),
              const SizedBox(
                width: 7,
              ),
              DropdownMenu(
                // initialSelection: selectedTopic,
                controller: topicController,
                width: 200.0,
                // requestFocusOnTap is enabled/disabled by platforms when it is null.
                // On mobile platforms, this is false by default. Setting this to true will
                // trigger focus request on the text field and virtual keyboard will appear
                // afterward. On desktop platforms however, this defaults to true.
                requestFocusOnTap: true,
                label: const Text('Topic'),
                onSelected: (String? topic) {
                  setState(() {
                    selectedTopic = topic;
                  });
                },
                dropdownMenuEntries:
                    topics.map<DropdownMenuEntry<String>>((String topic) {
                  return DropdownMenuEntry<String>(value: topic, label: topic);
                }).toList(),
              ),
              const SizedBox(
                width: 7,
              ),
              Expanded(
                child: TextFormField(
                  maxLines: 1,
                  controller: numMessageController,
                  // keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(
                    labelText: 'Number Of message',
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 7,
              ),
            ],
          ),
          const SizedBox(
            height: 7,
          ),

          const SizedBox(
            height: 7,
          ),

          TextFormField(
            maxLines: 5,
            controller: messageBodyController,
            decoration: InputDecoration(
              labelText: 'Message',
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(5.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),

          const SizedBox(
            height: 7,
          ),

          // Reponse
          TextFormField(
            maxLines: 3,
            controller: responseController,
            decoration: InputDecoration(
              labelText: 'Response',
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(5.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
          const SizedBox(height: 7),

          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ElevatedButton(
              onPressed: () async {},
              child: const Text("Save"),
            ),
            //
            const SizedBox(width: 5),
            //
            ElevatedButton(
              onPressed: () async {
                responseController.text = "";
                var numOfMsg = int.tryParse(numMessageController.text);
                var res = await publish(
                  messageBodyController.text,
                  numOfMsg ?? 1, // if numOfMsg is null default value is 1
                  topicController.text,
                );

                responseController.text =
                    "total message: ${res.data?.totalMessage} \nsuccess: ${res.data?.success} \nfailed: ${res.data?.failed}";
              },
              child: const Text("Publish"),
            )
          ])
        ],
      ),
    );
  }
}
