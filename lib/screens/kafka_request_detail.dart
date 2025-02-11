import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kafka_tool/bloc/request_bloc.dart';

class KafkaRequestDetail extends StatefulWidget {
  const KafkaRequestDetail({super.key});

  @override
  State<KafkaRequestDetail> createState() => _KafkaRequestDetailState();
}

class _KafkaRequestDetailState extends State<KafkaRequestDetail> {
  final messageBodyController = TextEditingController();
  final numMessageController = TextEditingController();
  final requestController = TextEditingController();
  final topicController = TextEditingController();
  final responseController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestBloc, RequestState>(builder: (context, state) {
      final selectedRequest = state.selectedRequest;
      if (selectedRequest == null) {
        return const Center(child: Text('Select and item from sidebar'));
      } else {
        debugPrint(
            'Detail request with id: ${selectedRequest.id} and title: ${selectedRequest.title}');
        requestController.text = selectedRequest.title;
        topicController.text = selectedRequest.topic;
        numMessageController.text = selectedRequest.quantity.toString();
      }

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
            const SizedBox(height: 7),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: requestController,
                    maxLines: 1,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 7),
                // TODO: update it to select topic from list topic
                //
                Expanded(
                  child: TextFormField(
                    controller: topicController,
                    maxLines: 1,
                    decoration: const InputDecoration(
                      labelText: 'Topic',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 7),
                Expanded(
                  child: TextFormField(
                    maxLines: 1,
                    controller: numMessageController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: InputDecoration(
                      labelText: "Number of messages",
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 7),
              ],
            ),
          ],
        ),
      );
    });
  }
}
