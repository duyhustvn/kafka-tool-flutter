import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kafka_tool/bloc/request_bloc.dart';
import 'package:kafka_tool/repositories/request_repository.dart';
import 'package:kafka_tool/screens/kafka_request_detail.dart';
import 'package:kafka_tool/screens/kafka_request_sidebar.dart';

class KafkaRequestScreen extends StatelessWidget {
  final String brokerName;

  const KafkaRequestScreen({super.key, required this.brokerName});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          RequestBloc(repository: RequestRepository())..add(LoadRequests()),
      child: Scaffold(
        // center the app bar
        appBar: AppBar(
          centerTitle: true,
          title: Text(brokerName),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Row(
              children: [
                SizedBox(
                  width: constraints.maxWidth * 0.2, // 20% of available width,
                  child: const KafkaRequestSidebar(),
                ),
                Expanded(
                  child: const SingleChildScrollView(
                    child: KafkaRequestDetail(),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
