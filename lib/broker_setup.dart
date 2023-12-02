import 'package:flutter/material.dart';
import 'package:kafka_tool/api/broker_connect_api.dart';
import 'package:kafka_tool/kafka_main.dart';

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

  @override
  void initState() {
    super.initState();
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
              } catch (e) {
                setState(() {
                  isLoading = false;
                  isConnectedKafkaBrokers = false;
                });
              } finally {
                setState(() {
                  displayConnectBrokerResult = true;
                });
              }
            },
            child: const Text("Connect"),
          ),
          const SizedBox(height: 7),
          _toggleNextButton(context),
        ],
      ),
    );
  }

  Widget _toggleNextButton(BuildContext context) {
    if (!displayConnectBrokerResult) {
      return Container();
    }

    if (isLoading) {
      return const CircularProgressIndicator();
    } else {
      if (isConnectedKafkaBrokers) {
        return ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const KafkaTabBar()),
            );
          },
          child: const Text("Next"),
        );
      } else {
        return const Text(
          "Cannot connect to kafka brokers",
          style: TextStyle(color: Colors.red),
        );
      }
    }
  }
}
