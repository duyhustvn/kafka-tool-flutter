import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kafka_tool/api/publish_msg_api.dart';
import 'package:kafka_tool/api/topic_list_api.dart';
import 'package:kafka_tool/api/request_list_api.dart';
import 'package:kafka_tool/api/request_create_api.dart';
import 'package:kafka_tool/api/request_update_api.dart';

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
        body: const TabBarView(
          children: <Widget>[
            BuildPublishWidget(),
            Center(
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
  final requestController = TextEditingController();
  final topicController = TextEditingController();
  final responseController = TextEditingController();
  String? selectedTopic;
  String? selectedRequestID;

  bool isLoading = false;
  bool saveRequestStatusSuccess = false;
  String msgStatus = "";

  List<String> topics = [];
  List<Request> requests = [];

  @override
  void initState() {
    super.initState();
    _listTopics();
    _listRequests();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    messageBodyController.dispose();
    numMessageController.dispose();
    requestController.dispose();
    topicController.dispose();
    responseController.dispose();
    super.dispose();
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
      // print("Error loading topics: $e");
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
      // print("Error loading requests: $e");
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
                controller: requestController,
                width: 200.0,
                // requestFocusOnTap is enabled/disabled by platforms when it is null.
                // On mobile platforms, this is false by default. Setting this to true will
                // trigger focus request on the text field and virtual keyboard will appear
                // afterward. On desktop platforms however, this defaults to true.
                requestFocusOnTap: true,
                label: const Text('Title'),
                onSelected: (Request? request) {
                  setState(() {
                    selectedRequestID = request!.id;
                  });
                  numMessageController.text = request!.quantity.toString();
                  topicController.text = request.topic;
                  messageBodyController.text = request.message;
                },
                dropdownMenuEntries:
                    requests.map<DropdownMenuEntry<Request>>((Request request) {
                  return DropdownMenuEntry<Request>(
                      value: request, label: request.title);
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
                  keyboardType: TextInputType.number,
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
            // Button save request
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  isLoading = true;
                  msgStatus = "";
                });
                try {
                  var id = selectedRequestID;
                  var requestTitle = requestController.text;
                  var topic = topicController.text;
                  var numOfMsg = int.parse(numMessageController.text);
                  var msg = messageBodyController.text;
                  // print("requestID: : $id requestTitle: $requestTitle topic: $topic numOfMsg: $numOfMsg msg: $msg");
                  if (id != null) {
                    await updateRequest(id, requestTitle, topic, numOfMsg, msg);
                  } else {
                    await createRequest(requestTitle, topic, numOfMsg, msg);
                  }
                  setState(() {
                    msgStatus = "Save message successfully";
                    saveRequestStatusSuccess = true;
                  });
                  _listRequests();
                } catch (e) {
                  // print("There is an error happened $e");
                  setState(() {
                    msgStatus = "Failed to save message";
                    saveRequestStatusSuccess = false;
                  });
                } finally {
                  setState(() {
                    isLoading = false;
                  });
                }
              },
              child: const Text("Save"),
            ),
            //
            const SizedBox(width: 5),
            // Button publish messages
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  isLoading = true;
                  msgStatus = "";
                });
                responseController.text = "";
                try {
                  var numOfMsg = int.parse(numMessageController.text);
                  String message = messageBodyController.text;
                  String topic = topicController.text;
                  var res = await publish(message, numOfMsg, topic);
                  if (res.status == "ok") {
                    responseController.text =
                        "total message: ${res.data?.totalMessage} \nsuccess: ${res.data?.success} \nfailed: ${res.data?.failed}";
                  } else {
                    responseController.text = res.msg.toString();
                  }
                } catch (e) {
                  responseController.text =
                      'There is an error happened. Please check the connection with API';
                } finally {
                  setState(() {
                    isLoading = false;
                  });
                }
              },
              child: const Text("Publish"),
            ),
          ]),
          //
          const SizedBox(height: 15),
          //
          _buildStatusMsg(context),
        ],
      ),
    );
  }

  Widget _buildStatusMsg(BuildContext context) {
    if (isLoading) {
      return const CircularProgressIndicator();
    }

    return Text(
      msgStatus,
      style: TextStyle(
          color: saveRequestStatusSuccess ? Colors.green : Colors.red),
    );
  }
}
