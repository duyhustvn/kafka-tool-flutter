import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kafka_tool/bloc/request_bloc.dart';
import 'package:kafka_tool/repositories/request_repository.dart';
import 'package:kafka_tool/screens/kafka_request_detail.dart';
import 'package:kafka_tool/screens/kafka_request_sidebar.dart';

class KafkaRequestScreen extends StatelessWidget {
  const KafkaRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          RequestBloc(repository: RequestRepository())..add(LoadRequests()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Kafka Tool')),
        drawer: const KafkaRequestSidebar(),
        body: BlocListener<RequestBloc, RequestState>(
          listener: (context, state) {
            if (state.error != null) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error!)));
            }
          },
          child: const KafkaRequestDetail(),
        ),
      ),
    );
  }
}
