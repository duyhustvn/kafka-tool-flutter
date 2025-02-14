import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
// API
import 'package:kafka_tool/api/broker_connect_api.dart';
import 'package:kafka_tool/bloc/broker_bloc.dart';
// UI
import 'package:kafka_tool/screens/kafka_request_detail.dart';
import 'package:kafka_tool/screens/kafka_request_screen.dart';

class BrokerSetupScreen extends StatelessWidget {
  const BrokerSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kafka Tool"),
      ),
      body: const Center(
        child: BrokerSetupWidget(),
      ),
    );
  }
}

class BrokerSetupWidget extends StatefulWidget {
  const BrokerSetupWidget({super.key});

  @override
  State<BrokerSetupWidget> createState() => _BrokerSetupWidget();
}

class _BrokerSetupWidget extends State<BrokerSetupWidget> {
  final brokersController = TextEditingController();

  bool isConnectedKafkaBrokers = false;
  bool displayConnectBrokerResult = false;
  bool isLoading = false;

  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    // if you want to use context from globally instead of content we need to pass navigatorKey.currentContext!
    fToast.init(context);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    brokersController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          const SizedBox(height: 7),
          TextFormField(
            maxLines: 1,
            controller: brokersController,
            decoration: InputDecoration(
              labelText: 'Brokers',
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
            onChanged: (String text) async {
              setState(() {
                displayConnectBrokerResult = false;
              });
            },
          ),
          const SizedBox(height: 7),
          ElevatedButton(
            onPressed: () async {
              try {
                String brokers = brokersController.text;
                setState(() {
                  isLoading = true;
                });
                await connectKafkaBrokers(brokers);
                setState(() {
                  isLoading = false;
                  isConnectedKafkaBrokers = true;
                });
                _showToast(
                    "Connected to kafka borkers successfully", "success");
              } catch (e) {
                setState(() {
                  isLoading = false;
                  isConnectedKafkaBrokers = false;
                });

                _showToast("Connect to kafka broker failed", "error");
              } finally {
                setState(() {
                  displayConnectBrokerResult = true;
                });
              }
            },
            child: const Text("Connect"),
          ),
          const SizedBox(height: 7),
          // _toggleNextButton(context),
          BlocBuilder<BrokerBloc, BrokerState>(
            builder: (context, state) {
              if (!displayConnectBrokerResult) {
                return Container();
              }

              if (isLoading) {
                return const CircularProgressIndicator();
              }

              if (isConnectedKafkaBrokers) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => KafkaRequestScreen(
                                    brokerName: brokersController.text)),
                          );
                        },
                        child: const Text("Next"),
                      )
                    ],
                  ),
                );
              } else {
                return Container();
              }
            },
          )
        ],
      ),
    );
  }

  Widget _toggleNextButton(BuildContext context) {
    return BlocBuilder<BrokerBloc, BrokerState>(
      builder: (context, state) {
        if (!displayConnectBrokerResult) {
          return Container();
        }

        if (isLoading) {
          return const CircularProgressIndicator();
        }

        if (isConnectedKafkaBrokers) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const KafkaRequestDetail()),
                    );
                  },
                  child: const Text("Next"),
                )
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  _showToast(String message, String toastType) {
    late MaterialAccentColor color;
    switch (toastType) {
      case "error":
        color = Colors.redAccent;
        break;
      case "success":
        color = Colors.greenAccent;
      case "warning":
        color = Colors.orangeAccent;
      default:
        color = Colors.cyanAccent;
    }

    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: color,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check),
          const SizedBox(
            width: 12.0,
          ),
          Text(message),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
    );
  }
}
