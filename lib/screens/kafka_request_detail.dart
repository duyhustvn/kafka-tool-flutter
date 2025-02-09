import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kafka_tool/bloc/request_bloc.dart';

class KafkaRequestDetail extends StatelessWidget {
  const KafkaRequestDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestBloc, RequestState>(builder: (context, state) {
      final selectedRequest = state.selectedRequest;
      if (selectedRequest == null) {
        return const Center(child: Text('Select and item from sidebar'));
      }

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
            const SizedBox(height: 7),
            TextFormField(
              initialValue: selectedRequest.title,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      );
    });
  }
}
