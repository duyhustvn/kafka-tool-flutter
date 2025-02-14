import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kafka_tool/bloc/broker_bloc.dart';
import 'package:kafka_tool/screens/broker_setup.dart';
import 'package:kafka_tool/repositories/broker_repository.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Kafka Tool",
      home: BlocProvider(
        create: (context) => BrokerBloc(
          repository: BrokerRepository(),
        ),
        // child: const KafkaRequestScreen(),
        child: const BrokerSetupScreen(),
      ),
    );
  }
}

void main() {
  runApp(const MainApp());
}
