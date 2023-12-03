import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kafka_tool/broker_setup.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: FToastBuilder(),
      theme: ThemeData(useMaterial3: true),
      home: const BrokerSetupScreen(),
    );
  }
}

void main() {
  runApp(const MainApp());
}
