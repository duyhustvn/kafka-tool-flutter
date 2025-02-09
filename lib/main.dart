import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kafka_tool/bloc/request_bloc.dart';
import 'package:kafka_tool/repositories/request_repository.dart';
import 'package:kafka_tool/screens/kafka_request_screen.dart';

// class MainApp extends StatelessWidget {
//   const MainApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       builder: FToastBuilder(),
//       theme: ThemeData(useMaterial3: true),
//       home: const BrokerSetupScreen(),
//     );
//   }
// }

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Kafka Tool",
      home: BlocProvider(
        create: (context) => RequestBloc(
          repository: RequestRepository(),
        )..add(LoadRequests()),
        child: const KafkaRequestScreen(),
      ),
    );
  }
}

void main() {
  runApp(const MainApp());
}
